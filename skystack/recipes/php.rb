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


node["php"].each do |mod|

  if mod["mysql"] == "1"
   node[:php][:modules][:mysql] = true
  
  elsif mod["curl"] == "1"
   node[:php][:modules][:curl] = true
  
  elsif mod["mcrypt"] == "1"
   node[:php][:modules][:mcrypt] = true           
  
  elsif mod["imagick"] == "1"
   node[:php][:modules][:imagick] = true
  
  elsif mod["gd"] == "1"
   node[:php][:modules][:gd] = true
  
  elsif mod["memcache"] == "1"
   node[:php][:modules][:memcache] = true

  elsif mod["xdebug"] == "1"
   node[:php][:modules][:xdebug] = true

  elsif mod["ffmpeg"] == "1"
   node[:php][:modules][:ffmpeg] = true

  elsif mod["geoip"] == "1"
   node[:php][:modules][:geoip] = true
  
  elsif mod["xsl"] == "1"
   node[:php][:modules][:xsl] = true
       
  elsif mod["ldap"] == "1"
   node[:php][:modules][:ldap] = true
  
  elsif mod["apc"] == "1"
   node[:php][:modules][:apc] = true
  
  elsif mod["mongo"] == "1"
   node[:php][:modules][:mongo] = true
  
  elsif mod["pgsql"] == "1"
   node[:php][:modules][:pgsql] = true
  
  elsif mod["sqlite3"] == "1"
   node[:php][:modules][:sqlite3] = true
  
  elsif mod["fpdf"] == "1"
   node[:php][:modules][:fpdf] = true
  
  elsif mod["fileinfo"] == "1"
   node[:php][:modules][:fileinfo] = true
  end       
  
end

#if node["attributes"]["php"]
#   node[:php] = node["attributes"]["php"]
#end

include_recipe "php::php5"
include_recipe "php::php5-cgi"


