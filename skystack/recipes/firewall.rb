# Cookbook Name:: skystack
# Recipe:: skystack::firewall
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
{"name":"skystack::firewall","methods":["toggle_rules"],"symbol":":firewall","properties":{"all_established":"boolean","all_lo":"boolean","all_icmp":"boolean","all_ssh":"boolean","all_www":"boolean"}}
=end
include_recipe "iptables"

  node[:security] = "custom"

  if node[:security] == "hardened"
    #deny-by-default
    iptables_rule "firewall_all_established" do
      order 0
    end
    iptables_rule "firewall_all_lo" do
      order 10
    end
    
    iptables_rule "firewall_all_icmp" do
      order 20
    end
    
    iptables_rule "firewall_all_ssh" do
      order 30
    end
    
  end
  
    if node[:firewall]
       node[:firewall].each do |rule|
          iptables_rule "firewall_#{rule}" do 
            order 50
          end
      end

     iptables_rule "firewall_all_drop" do 
       order 99
    end
     
  else
    # else minimal
    #  iptables_rule "firewall_all_loopback"
    #  iptables_rule "firewall_all_established"
    #  iptables_rule "firewall_all_icmp"
  end

