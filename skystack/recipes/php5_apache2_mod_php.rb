#
# Cookbook Name:: skystack_apps
# Recipe:: php5_apache2_mod_php
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
app = node.run_state[:current_app]

node[:apache][:mpm] = "prefork"
node[:webserver] = "apache2"

include_recipe "php::php5"  
include_recipe "apache2"
  
  
  if app["ssl"] == 1
    include_recipe "apache2::mod_ssl"
  end
  
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_expires"

Chef::Log.info "skystack_apps::php5_apache2_mod_php preparing to add virtual hosts and document roots."

node[:apps].each do |app|
  Chef::Log.info "skystack_apps::php5_apache2_mod_php adding #{app["domain"]} to #{node[:webserver]}"
  web_app app["domain"] do
    template "skybuild_php5_#{node[:webserver]}.erb"
    docroot app["docroot"]
    server_name app["domain"]
    server_aliases app["server_aliases"]
  end
  
  Chef::Log.info "skystack_apps::php5_apache2_mod_php creating #{app["docroot"]}"
  directory app["docroot"] do
    owner "www-data"
    group "www-data"
    mode "0755"
    action :create
    recursive true
  end
  
  cookbook_file "#{app["docroot"]}/index.php" do
    source "index.php"
    mode 0755
    owner "www-data"
    group "www-data"
    action :create_if_missing
   end  
end

Chef::Log.info "skystack_apps::php5_apache2_mod_php disabling default Apache site."
apache_site "000-default" do
  enable false
end