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


packages = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => %w(php php-cli php5-dev)}, "default" => %w{php5 php5-cli php5-dev php5-common php::pear php5-suhosin})

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end

node[:php][:modules].each |mod|
  include_recipe "php::module_#{mod}"  
end

template "#{node[:php][:dir]}/#{node[:php][:type] }/php.ini" do
   source "php.ini.erb"
   owner "root"
   group "root"
   mode 0644
   action :create
end
