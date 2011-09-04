#
# Cookbook Name:: skystack
# Recipe:: php
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

node['skystack_php'].each do |php|

  php["extensions"].each do |value|
   puts "value:#{value}"
   if !value.nil?
     node.default[:php][:modules][value.to_sym] = 1
   end
  end

end

include_recipe "php"
include_recipe "php::php5-cgi"



