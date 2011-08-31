#
# Cookbook Name:: PHP
# Attributes:: PHP
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

set_unless[:php][:dir]      = "/etc/php5"
set_unless[:php][:type]     = "cgi"

# General settings
set_unless[:php][:error_reporting]     = "E_ALL & ~E_DEPRECATED"
set_unless[:php][:memory_limit]        = "32M"
set_unless[:php][:error_log]           = "/var/log/php_error.log"
set_unless[:php][:post_max_size]       = "16M"
set_unless[:php][:upload_max_filesize] = "16M"
set_unless[:php][:allow_url_fopen]     = "On"
set_unless[:php][:date_timezone]       = "Europe/London"
set_unless[:php][:php_path]            = "/etc/php5"


set_unless['php']['extensions']['gd']         = true
set_unless['php']['extensions']['curl']       = true
set_unless['php']['extensions']['xsl']        = true
set_unless['php']['extensions']['mcrypt']     = true
set_unless['php']['extensions']['apc']        = true

set_unless['php']['extensions']['xdebug']     = false
set_unless['php']['extensions']['geoip']      = false
set_unless['php']['extensions']['ffmpeg']     = false
set_unless['php']['extensions']['imagick']    = false

set_unless['php']['extensions']['mysql']      = false
set_unless['php']['extensions']['memcache']   = false
set_unless['php']['extensions']['mongo']      = false
set_unless['php']['extensions']['sqlite3']    = false
set_unless['php']['extensions']['fileinfo']   = false
set_unless['php']['extensions']['pgsql']      = false
set_unless['php']['extensions']['ldap']       = false
set_unless['php']['extensions']['fpdf']       = false


