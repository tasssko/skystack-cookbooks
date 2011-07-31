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

=begin
{"name":"skystack::newrelic","order":"auto","cookbook":"newrelic","methods":["install","update","pause"],"symbol":":newrelic","properties":{"appname":"string","php":"boolean","ruby":"boolean"}}
=end

include_recipe "newrelic::default"

node[":newrelic"].each do |nr|

  if(nr['php'] == "1")
  
    include_recipe "newrelic::php"
  
  elsif (nr['ruby'] == "1")
  
    include_recipe "newrelic::ruby"
  
  end
  
end