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



include_recipe "php::php5"
include_recipe "php::php5-cgi"

apache_module "php5" do
  enable false
end

node['skystack_php'].each do |php|
  php["extensions"].each do |value|

   if !value.nil?
     include_recipe "php::module_#{value}"
   end
   
  end
end
