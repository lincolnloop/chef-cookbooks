include_recipe "postgresql::client"

%w{postgresql postgresql-server-dev-%s postgresql-contrib-%s}.each do |pkg|
  package pkg % node[:postgresql][:version] do
    action :upgrade
  end
end

service "postgresql" do
  service_name "postgresql"
  supports :restart => true, :status => true, :reload => true
  action :nothing
end

template "#{node[:postgresql][:dir]}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :reload, resources(:service => "postgresql")
end

template "#{node[:postgresql][:dir]}/postgresql.conf" do
  source "postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :restart, resources(:service => "postgresql")
end

unless Chef::Config[:solo]
  ruby_block "save node data" do
    block do
      node.save
    end
    action :create
  end
end

# Create users and grant privileges using the grants.sql template

grants_path = "/etc/postgresql/#{node[:postgresql][:version]}/main/grants.sql"

template grants_path do
  path grants_path
  source "grants.sql.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
  notifies :run, "execute[postgresql-install-privileges]"
end

execute "postgresql-install-privileges" do
  command "cat #{grants_path} | sudo -u postgres psql"
  action :nothing
end
