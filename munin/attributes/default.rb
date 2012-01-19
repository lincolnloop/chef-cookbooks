default['munin']['server_ips'] = []  # A list of IP address strings
default['munin']['override_hostname'] = nil

default['munin']['basedir'] = "/etc/munin"
default['munin']['plugin_dir'] = "/usr/share/munin/plugins"
default['munin']['docroot'] = "/var/www/munin"
default['munin']['dbdir'] = "/var/lib/munin"
default['munin']['root']['group'] = "root"

default['munin']['plugins'] = "#{default['munin']['basedir']}/plugins"
default['munin']['tmpldir'] = "#{default['munin']['basedir']}/templates"
