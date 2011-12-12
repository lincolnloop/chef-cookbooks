default[:postgresql][:version] = "9.1"
default[:postgresql][:listen_addresses] = "localhost"
default[:postgresql][:port] = 5432
default[:postgresql][:max_connections] = 100
default[:postgresql][:ssl] = "true"
default[:postgresql][:shared_buffers] = "24MB"
default[:postgresql][:work_mem] = "1MB"
default[:postgresql][:checkpoint_segments] = 3
default[:postgresql][:effective_cache_size] = "128MB"
default[:postgresql][:wal_buffers] = "64kB"
default[:postgresql][:maintenance_work_mem] = "16MB"
default[:postgresql][:synchronous_commit] = "on"

unless Chef::Config[:solo]
  ::Chef::Node.send(:include, Opscode::OpenSSL::Password)
  default[:postgresql][:server_root_password] = secure_password
end

set[:postgresql][:dir] = "/etc/postgresql/#{node[:postgresql][:version]}/main"

# # Replication master
# default[:postgresql][:wal_level]
# default[:postgresql][:archive_mode]
# default[:postgresql][:archive_command]
# default[:postgresql][:max_wal_senders]
# 
# # Replication slave
# default[:postgresql][:hot_standby]
# default[:postgresql][:max_standby_archive_delay]
# default[:postgresql][:max_standby_streaming_delay]
