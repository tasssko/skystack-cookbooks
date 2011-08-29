# Cookbook Name:: skystack
# Recipe:: skystack::site
# Copyright:: 2010, Skystack Limited.
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

node[:webserver] ="apache2"

app = node.run_state[:current_app]

node[:apache][:listen_ports] = [ "80" ]
include_recipe "apache2"


Chef::Log.info "skystack::apache2 preparing to add virtual hosts and document roots."
node["sites"].each do |site|
  if site["ssl"] == 1
    include_recipe "apache2::mod_ssl"
  end

  Chef::Log.info "skystack::apache2 adding #{site["server_name"]} to server"
  web_app site["server_name"] do
    template "skybuild_php5_#{node[:webserver]}.erb"
    docroot site["document_root"]
    server_name site["server_name"]
    server_aliases site["server_aliases"]
  end

  Chef::Log.info "skystack::apache2 creating #{site["document_root"]}"
  directory site["document_root"] do
    owner "www-data"
    group "www-data"
    mode "0755"
    action :create
    recursive true
  end

  cookbook_file "#{site["document_root"]}/index.php" do
    source "index.php"
    mode 0755
    owner "www-data"
    group "www-data"
    action :create_if_missing
   end
   
#  if site["is_enabled"] == "0"
#    enabled = false
#   else
#    enabled = true
#   end
   
#   apache_site site["server_name"] do
#     enable enabled
#   end
   
end

Chef::Log.info "skystack::apache2 disabling default Apache site."
apache_site "000-default" do
  enable false
end