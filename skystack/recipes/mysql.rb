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


class Chef::Recipe
 include Opscode::OpenSSL::Password
end

include_recipe "build-essential"

mysql_conf = "/opt/skystack/bootstrapper/etc/.mysql.root.shadow"

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

node["mysql_databases"].each do |db|
   new_password = secure_password
   mysql_database "create_#{db["name"]}" do
      root_username "root"
      root_password node[:mysql][:server_root_password]
      database db["name"]
      username db["user"]
      password new_password
      host "localhost"
      priv "#{db["permissions"].join(",")}"
      action [:create, :grant, :flush]
   end
    
   ruby "save_password" do
      interpreter "ruby"
      user "root"
      cwd "/tmp"
      code <<-EOH
        mysql_conf = "/opt/skystack/bootstrapper/etc/.mysql.#{db["user"]}.shadow"
        open(mysql_conf, 'a') do |f| f << "#{new_password}" end
      EOH
      only_if do ! File.exists?( "/opt/skystack/bootstrapper/etc/.mysql.#{db["user"]}.shadow" ) end
      action :run
   end
end