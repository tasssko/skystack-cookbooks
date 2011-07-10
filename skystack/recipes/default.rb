# Cookbook Name:: skystack
# Recipe:: skystack::default
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

require 'ohai'
 o = Ohai::System.new
 o.all_plugins
 total_memory = o[:memory][:total].tr('kb','').to_i()
 free_memory = o[:memory][:free].tr('kb','').to_i()
 size = case total_memory
  when total_memory < 630000 then 0.5
  when total_memory < 1048576 then 1
  when total_memory < 2097152 then 2
  when total_memory < 4194304 then 4
  when total_memory < 8388608 then 8
  when total_memory < 16777216 then 16  
  when total_memory < 33554432 then 32
  when total_memory < 67108864 then 64 
end

node[:system][:size] = size

if node[:apps]
  node[:apps].each do |app|
        node.run_state[:current_app] = app
        
        if node[:security] == "hardened"
           node[:firewall] = 'all_www'
        end
        
        Chef::Log.info "skystack::default preparing web server, this may take a while."
        include_recipe "skystack::#{app["type"]}"
        node.run_state.delete(:current_app)
  end
end

if node[:dbs]
  node[:dbs].each do |db|
      node.run_state[:current_app] = db
      Chef::Log.info "skystack::default preparing databases, this may take a while."
      include_recipe "skystack::#{db["type"]}"
      node.run_state.delete(:current_app)
  end
end

if node[:scripts]
  node[:scripts].each do |script|
      node.run_state[:current_app] = script
      Chef::Log.info "skystack::default fetching SkyScripts"
      include_recipe "skystack::#{script[:type]}"
      node.run_state.delete(:current_app)
  end
end

if node[:access]
  node[:access].each do |access|
      node.run_state[:current_app] = access
      Chef::Log.info "skystack::default fetching SkyAccess"
      include_recipe "skystack::#{access[:type]}"
      node.run_state.delete(:current_app)
  end
end

  # Minimal settings will be loaded by default so no testing just include it here.
    include_recipe "skystack::firewall"
