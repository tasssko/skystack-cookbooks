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
set_unless[:php][:type]     = "apache2"

# General settings
set_unless[:php][:error_reporting]     = "E_ALL & ~E_DEPRECATED"
set_unless[:php][:memory_limit]        = "32M"
set_unless[:php][:error_log]           = "/var/log/php_error.log"
set_unless[:php][:post_max_size]       = "16M"
set_unless[:php][:upload_max_filesize] = "16M"
set_unless[:php][:allow_url_fopen]     = "On"
set_unless[:php][:date_timezone]       = "Europe/London"
set_unless[:php][:php_path]            = "/etc/php5"


set_unless[:php][:modules][:gd]         = true
set_unless[:php][:modules][:curl]       = true
set_unless[:php][:modules][:xsl]        = true
set_unless[:php][:modules][:mcrypt]     = true
set_unless[:php][:modules][:apc]        = false
set_unless[:php][:modules][:xdebug]     = false
set_unless[:php][:modules][:geoip]      = false
set_unless[:php][:modules][:ffmpeg]     = false
set_unless[:php][:modules][:imagick]    = false
set_unless[:php][:modules][:mysql]      = false
set_unless[:php][:modules][:memcache]   = false
set_unless[:php][:modules][:mongo]      = false
set_unless[:php][:modules][:sqlite3]    = false
set_unless[:php][:modules][:fileinfo]   = false
set_unless[:php][:modules][:pgsql]      = false
set_unless[:php][:modules][:ldap]       = false
set_unless[:php][:modules][:fpdf]       = false


