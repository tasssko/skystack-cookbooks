# Cookbook Name:: skystack
# Recipe:: skystack::script
# Description:: Multi-purpose recipe for executing SkyScripts during the bootstrap/commission and decommission phases, the recipe uses a lock file to prevent further execution.
# Copyright:: 2010, Skystack, Ltd.
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

script = node.run_state[:current_app]


node["scripts"].each do |script|
  Chef::Log.info "skystack::script telling chef to run this script #{script["skyscript_id"]}"
  script["ext"] = File.extname(script["resource"])
  execute "run_skyscript_#{script["skyscript_id"]}" do
    command "/tmp/#{script["skyscript_id"]}#{script["ext"]};touch /opt/skystack/tmp/executed-#{script["skyscript_id"]}"
    action :nothing
    only_if do ! File.exists?( "/opt/skystack/tmp/executed-#{script["skyscript_id"]}" ) end
  end
  #all interactions with our API should be done via a Ruby script to cleanup the execution of a SkyScript.
  Chef::Log.info "skystack::script via skystack we fetch the script contents #{script["skyscript_id"]}"
  bash "get_skyscript" do
    interpreter "#{script["ext"].gsub(".", "")}"
    user "root"
    cwd "/tmp"
    code <<-EOH
    export SKYSTACK_PATH=/opt/skystack
    export SS_ALIAS=`awk '/SS_ALIAS/ {print $2}' FS=\= $SKYSTACK_PATH/etc/userdata.conf` > /dev/null 2>&1
    export SS_APITOKEN=`awk '/SS_APITOKEN/ {print $2}' FS=\= $SKYSTACK_PATH/etc/userdata.conf` > /dev/null 2>&1
    export SS_APIUSER=`awk '/SS_APIUSER/ {print $2}' FS=\= $SKYSTACK_PATH/etc/userdata.conf` > /dev/null 2>&1
    export SS_BASE=`awk '/SS_BASE/ {print $2}' FS=\= $SKYSTACK_PATH/etc/userdata.conf` > /dev/null 2>&1

    HTTP=https

    curl -k -o /tmp/#{script["skyscript_id"]}_part -u $SS_APIUSER:$SS_APITOKEN $HTTP://$SS_BASE/$SS_ALIAS/scripts/#{script["skyscript_id"]}#{script["ext"]}
    tr -d '\015\032' < /tmp/#{script["skyscript_id"]}_part > /tmp/#{script["skyscript_id"]}#{script["ext"]}
    chmod +x /tmp/#{script["skyscript_id"]}#{script["ext"]}
    EOH
    notifies :run, resources(:execute => "run_skyscript_#{script["skyscript_id"]}")
    creates "/tmp/#{script["skyscript_id"]}#{script["ext"]}"
  end
end