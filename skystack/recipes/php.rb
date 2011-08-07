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


=begin
{"name":"skystack::php","order":"auto","cookbook":"php","methods":["add_php_modules"],"symbol":":php","properties":{"mysql":"boolean","apc":"boolean","curl":"boolean","memcache":"boolean","gd":"boolean","ldap":"boolean","pgsql":"boolean","fpdf":"boolean","fileinfo":"boolean","sqlite3":"boolean"}}
=end

if node["attributes"]["php"]
   node[:php] = node["attributes"]["php"]
end

include_recipe "php::php5"
include_recipe "php::php5-cgi"


