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
require_recipe "apt"
include_recipe "build-essential"
