# Cookbook Name:: skystack
# Recipe:: script
# Description:: Multi-purpose recipe for executing SkyScripts during the bootstrap/commission and decommission phases, the recipe uses a lock file to prevent further execution.
# Parameters:: script[:script_id],script[:ext],script[:type]
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

=beginjson
{"name":"skystack::script","methods":["run_script","edit_script","delete_script"],"symbol":":script","properties":{"skyscript_id":"string","resource":"string"}}
=end

script = node.run_state[:current_app]

execute "run_skyscript_#{script[:skyscript_id]}" do
  command "bash /tmp/#{script[:skyscript_id]}.sh;touch /opt/skystack/bootstrapper/executed-#{script[:skyscript_id]}"
  action :nothing
  only_if do ! File.exists?( "/opt/skystack/bootstrapper/executed-#{script[:skyscript_id]}" ) end
end
#all interactions with our API should be done via a Ruby script to cleanup the execution of a SkyScript.
bash "get_skyscript" do
  interpreter "#{script[:type]}"
  user "root"
  cwd "/tmp"
  code <<-EOH
  export SKYSTACK_PATH=/opt/skystack
  export SS_ALIAS=`awk '/SS_ALIAS/ {print $2}' FS=\= $SKYSTACK_PATH/bootstrapper/etc/userdata.conf` > /dev/null 2>&1
  export SS_APITOKEN=`awk '/SS_APITOKEN/ {print $2}' FS=\= $SKYSTACK_PATH/bootstrapper/etc/userdata.conf` > /dev/null 2>&1
  export SS_APIUSER=`awk '/SS_APIUSER/ {print $2}' FS=\= $SKYSTACK_PATH/bootstrapper/etc/userdata.conf` > /dev/null 2>&1

  curl -o /tmp/tmp_#{script[:skyscript_id]}.sh -u $SS_APIUSER:$SS_APITOKEN https://my.skystack.com/$SS_ALIAS/sky_build/sky_scripts/#{script[:skyscript_id]}.bash
  tr -d '\015\032' < /tmp/tmp_#{script[:skyscript_id]}.#{script[:ext]} > /tmp/#{script[:skyscript_id]}.#{script[:ext]}
  EOH
  notifies :run, resources(:execute => "run_skyscript_#{script[:skyscript_id]}")
  creates "/tmp/tmp_#{script[:skyscript_id]}.#{script[:ext]}"
end
