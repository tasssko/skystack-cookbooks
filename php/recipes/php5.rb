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



if node[:php][:modules][:mysql]
    include_recipe "php::module_mysql"     
    
elsif node[:php][:modules][:curl]
    include_recipe "php::module_curl"
    
elsif node[:php][:modules][:gd]
    include_recipe "php::module_gd"
    
elsif node[:php][:modules][:memcache]
    include_recipe "php::module_memcache"
    
elsif node[:php][:modules][:ldap]
    include_recipe "php::module_ldap"
    
elsif node[:php][:modules][:apc]
    include_recipe "php::module_apc"
   
elsif node[:php][:modules][:mongo]
    include_recipe "php::module_mongo"
  
elsif node[:php][:modules][:pgsql]
    include_recipe "php::module_pgsql"
    
elsif node[:php][:modules][:sqlite3]
    include_recipe "php::module_sqlite3"

elsif node[:php][:modules][:fpdf]
    include_recipe "php::module_fpdf"

elsif node[:php][:modules][:xsl]
    include_recipe "php::module_xsl"

elsif node[:php][:modules][:fileinfo]
    include_recipe "php::module_fileinfo"
         
elsif node[:php][:modules][:geoip]
    include_recipe "php::module_geoip"
    
elsif node[:php][:modules][:imagick]
    include_recipe "php::module_imagick"

elsif node[:php][:modules][:xdebug]
    include_recipe "php::module_xdebug"
      
elsif node[:php][:modules][:mcrypt]
    include_recipe "php::module_mcrypt"
end


template "#{node[:php][:dir]}/#{node[:php][:type] }/php.ini" do
   source "php.ini.erb"
   owner "root"
   group "root"
   mode 0644
   action :create
end
