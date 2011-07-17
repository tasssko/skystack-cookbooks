# Cookbook Name:: skystack
# Recipe:: skystack::mysql
#
# Copyright 2010, Skystack, Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

=begin
{"name":"skystack::mysql","methods":["add_database","edit_database","delete_database"],"symbol":":dbs","properties":{"name":"string","user":"string","permissions":["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "DROP"]}}
=end

class Chef::Recipe
 include Opscode::OpenSSL::Password
end

include_recipe "build-essential"

mysql_conf = "/opt/skystack/bootstrapper/etc/.mysql.shadow"

include_recipe "mysql"
include_recipe "openssl"
include_recipe "mysql::server"


ruby_block "fetch_root_password" do
  block do
    if File.exists?( mysql_conf ) 
      node[:mysql][:server_root_password] = File.read mysql_conf
    end
  end
  only_if do File.exists?( mysql_conf ) end
end

node[":dbs"].each do |db|
   new_password = secure_password
    
   mysql_database "create_#{db["db_name"]}" do
      root_username "root"
      root_password node[:mysql][:server_root_password]
      database db["db_name"]
      username db["db_user"]
      password new_password
      host "localhost"
      priv "#{db["permissions"]}"
      action [:create, :grant, :flush]
   end
    
   ruby "save_password" do
      interpreter "ruby"
      user "root"
      cwd "/tmp"
      code <<-EOH
        mysql_conf = "/opt/skystack/bootstrapper/etc/.mysql.#{db["db_user"]}.shadow"
        open(mysql_conf, 'a') do |f| f << "#{new_password}" end
      EOH
      only_if do ! File.exists?( "/opt/skystack/bootstrapper/etc/.mysql.#{db["db_user"]}.shadow" ) end
      action :run
   end
end