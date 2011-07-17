include Opscode::Mysql::Database

action :create do
  Chef::Log.info "mysql_database: executing a create if not exists on #{new_resource.database}"
  db.query("CREATE DATABASE IF NOT EXISTS #{new_resource.database};")
  new_resource.updated = true
end

action :grant do
  Chef::Log.info "mysql_database: executing grant on #{new_resource.database} for #{new_resource.username}"
  db.query("GRANT #{new_resource.priv} ON #{new_resource.database}.* TO `#{new_resource.username}`@`#{new_resource.host}` IDENTIFIED BY '#{new_resource.password}';")
  new_resource.updated = true
end

action :drop do
  Chef::Log.info "mysql_database: dropping #{new_resource.database}"
  db.query("DROP DATABASE #{new_resource.database};")
  new_resource.updated = true
end

action :flush_tables_with_read_lock do
  Chef::Log.info "mysql_database: flushing tables with read lock"
  db.query "flush tables with read lock"
  new_resource.updated = true
end

action :flush do
  Chef::Log.info "mysql_database: flushing privileges"
  db.query("FLUSH PRIVILEGES;")
  new_resource.updated = true
end

action :unflush_tables do
  Chef::Log.info "mysql_database: unlocking tables"
  db.query "unlock tables"
  new_resource.updated = true
end
