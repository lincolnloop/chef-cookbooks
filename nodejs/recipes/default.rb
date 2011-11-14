package "build-essential"
package "curl"
package "libssl-dev"

bash "compile nodejs from source" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
    wget http://nodejs.org/dist/#{node[:nodejs][:version]}/node-#{node[:nodejs][:version]}.tar.gz
    tar zxf node-#{node[:nodejs][:version]}.tar.gz
    cd node-#{node[:nodejs][:version]}
    ./configure && make && make install
  EOH
  not_if "/usr/local/bin/node -v 2>&1 | grep 'v#{node[:nodejs][:version]}'"
end

bash "install_npm" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
    curl http://npmjs.org/install.sh | clean=no sh
  EOH
  not_if do
    File.exists?("/usr/local/bin/npm")
  end
end
