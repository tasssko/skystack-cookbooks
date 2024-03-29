#
# Cookbook Name:: skystack
# Recipe:: newrelic
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


node["newrelic_agent"].each do |nr|
  
  node[:newrelic][:appname] = nr["app_name"]
  node[:newrelic][:license_key] = nr["license_key"]
#  node[:newrelic][:version] = nr["version"]
  
  include_recipe "newrelic::default"
  
  if(nr["is_php_enabled"] == "1")
    
    include_recipe "newrelic::php"
  
#  elsif (nr['ruby'] == "1")
#    include_recipe "newrelic::ruby"
  
  end
  
end