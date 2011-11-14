package "curl"
package "libssl-dev"

bash "compile nodejs from source" do
  user "root"
  cwd "/usr/local/src"
  code <<-EOH
    if [ ! -f node-v#{node[:nodejs][:version]}.tar.gz ];
    then
      wget http://nodejs.org/dist/v#{node[:nodejs][:version]}/node-v#{node[:nodejs][:version]}.tar.gz
    fi
    
    if [ ! -d node-v#{node[:nodejs][:version]} ];
    then
      tar zxf node-v#{node[:nodejs][:version]}.tar.gz
    fi
    
    cd node-v#{node[:nodejs][:version]}
    ./configure && make && make install
  EOH
  not_if "/usr/local/bin/node -v 2>&1 | grep 'v#{node[:nodejs][:version]}'"
end

bash "install npm" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
    curl http://npmjs.org/install.sh | clean=no sh
  EOH
  not_if do
    File.exists?("/usr/local/bin/npm")
  end
end
