#
# Author::  Joshua Timberman (<joshua@opscode.com>)
# Cookbook Name:: php
# Recipe:: php5
#
# Copyright 2009, Opscode, Inc.
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


packages = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => %w(php php-cli php5-dev)}, "default" => %w{php5 php5-cli php5-dev php5-common php5-suhosin})

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

node[:php][:type] = "apache2"

include_recipe "php::pear"

node[":php"].each do |mod|

  if mod["mysql"] == 1
      include_recipe "php::module_mysql"
  elsif mod["curl"] == 1
      include_recipe "php::module_curl"
  elsif mod["gd"] == 1
      include_recipe "php::module_gd" 
  elsif mod["memcache"] == 1
      include_recipe "php::module_memcache"
  elsif mod["ldap"] == 1
      include_recipe "php::module_ldap"
  elsif mod["apc"] == 1
      include_recipe "php::module_apc"
  elsif mod["mongo"] == 1
      include_recipe "php::module_mongo"
  elsif mod["pgsql"] == 1
      include_recipe "php::module_pgsql"
  elsif mod["sqlite3"] == 1
      include_recipe "php::module_sqlite3"
  elsif mod["fpdf"] == 1
      include_recipe "php::module_fpdf"
  elsif mod["fileinfo"] == 1
      include_recipe "php::module_fileinfo"
  end       
  
end

template "#{node[:php][:dir]}/#{node[:php][:type] }/php.ini" do
   source "php.ini.erb"
   owner "root"
   group "root"
   mode 0644
   action :create
end
