define :munin_plugin, :create_file => false, :enable => true do

  include_recipe "munin::client"

  plugin = params[:plugin] ? params[:plugin] : params[:name]
  plugin_config = params[:plugin_config] ? params[:plugin_config] : node['munin']['plugins']
  plugin_dir = params[:plugin_dir] ? params[:plugin_dir] : node['munin']['plugin_dir']

  if params[:create_file]
    cookbook_file "#{plugin_dir}/#{params[:name]}" do
      cookbook "munin"
      source "plugins/#{params[:name]}"
      owner "root"
      group node['munin']['root']['group']
      mode 0755
    end
  end

  link "#{plugin_config}/#{plugin}" do
    to "#{plugin_dir}/#{params[:name]}"
    if params[:enable]
      action :create
    else
      action :delete
    end
    notifies :restart, resources(:service => "munin-node")
  end

end
