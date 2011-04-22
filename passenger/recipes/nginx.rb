include_recipe "passenger"

package "rake" # Required in order to build the package

gems_dir = node[:languages][:ruby][:gems_dir]
nginx_path = node[:nginx][:source_path]
nginx_ver = node[:nginx][:version]
nginx_src = "#{nginx_path}/nginx-#{nginx_ver}"
passenger_ver = node[:passenger][:version]
passenger_root = "#{gems_dir}/gems/passenger-#{passenger_ver}"

unless File.directory?(nginx_path)
  begin
    
    log "Building nginx-passenger"
    
    directory nginx_path
    
    execute "install nginx build deps" do
      command "apt-get build-dep -y nginx"
      cwd nginx_path
    end
    
    execute "download nginx source package" do
      command "apt-get source nginx=#{nginx_ver}"
      cwd nginx_path
    end
    
    configure_opts = ["--with-http_ssl_module",
                       "--add-module=#{passenger_root}/ext/nginx"].join(" ")
    
    execute "compile nginx" do
      command "dpkg-buildpackage"
      cwd nginx_src
      environment "CONFIGURE_OPTS" => configure_opts
    end
    
    execute "install the custom packages" do
      command "dpkg -i nginx*.deb"
      cwd nginx_path
    end
    
    execute "hold the nginx package" do
      command 'echo "nginx hold" | sudo dpkg --set-selections'
    end
    
    execute "hold the nginx-dbg package" do
      command 'echo "nginx-dbg hold" | sudo dpkg --set-selections'
    end
    
  rescue
    
    # Make sure that the directory goes away if there's an error, so that the
    # install will be attempted again on the next Chef run
    directory nginx_path do
      action :delete
      recursive true
    end
    
  end
end

include_recipe "nginx::base"

template node[:nginx][:conf_dir] + "/passenger.conf" do
  source "passenger.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "nginx")
end