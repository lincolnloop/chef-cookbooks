package "munin-node"

service "munin-node" do
  supports :restart => true
  action :enable
end

template "#{node['munin']['basedir']}/munin-node.conf" do
  source "munin-node.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "munin-node")
end
