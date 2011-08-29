# Cookbook Name:: skystack
# Recipe:: skystack::mongodb
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

db = node.run_state[:current_app]
include_recipe "mongodb::source"

mongo_conf = "/opt/skystack/bootstrapper/etc/.mongodb.shadow"

ruby_block "save_password" do
  block do
    open(mongo_conf, 'w') do |f| f << "#{node[:mongodb][:username]}/#{node[:mongodb][:password]}" end
  end
  action :create
  only_if do ! File.exists?( mongo_conf ) end
end

end


  
  