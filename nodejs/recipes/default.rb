package "curl"
package "libssl-dev"

bash "compile_nodejs_source" do
  cwd "/tmp/"
  code <<-EOH
    git clone https://github.com/joyent/node.git
    cd node
    git checkout #{node[:nodejs][:version]}
    ./configure && make && make install
  EOH
  not_if do
    File.exists?("/usr/local/bin/node")
  end
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
