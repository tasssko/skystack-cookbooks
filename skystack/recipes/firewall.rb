# Cookbook Name:: skystack
# Recipe:: skystack::newrelic
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


node["firewall"].each do |rule|
 
  if rule["all_established"] == "1"
    iptables_rule "firewall_all_established" do
      order 0
    end
  end

  if rule["all_lo"] == "1"
    iptables_rule "firewall_all_lo" do
      order 10
    end
  end

  if rule["all_icmp"] == "1"
    iptables_rule "firewall_all_icmp" do
      order 20
    end
  end

  if rule["all_www"] == "1"
    iptables_rule "firewall_all_www" do
      order 40
    end
  end
  
end #end block
      
  iptables_rule "firewall_all_ssh" do
    order 30
  end
  
  iptables_rule "firewall_all_drop" do 
    order 200
  end
  
