maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and maintains php and php modules"
version           "0.9.1"
depends           "apache2"
recipe            "php", "Empty, use one of the other recipes"
recipe            "php::module_apc", "Install the php5-apc package"
recipe            "php::module_curl", "Install the php5-curl package"
recipe            "php::module_fileinfo", "Install the php5-fileinfo package"
recipe            "php::module_fpdf", "Install the php-fpdf package"
recipe            "php::module_gd", "Install the php5-gd package"
recipe            "php::module_ldap", "Install the php5-ldap package"
recipe            "php::module_memcache", "Install the php5-memcache package"
recipe            "php::module_mysql", "Install the php5-mysql package"
recipe            "php::module_pgsql", "Install the php5-pgsql packag"
recipe            "php::module_sqlite3", "Install the php5-sqlite3 package"
recipe            "php::pear", "Install the php-pear package"
recipe            "php::php5-cgi", "Install the php5-cgi package"
recipe            "php::php5", "Install php5 packages and php.ini config file"


attribute "php/error_reporting",
  :display_name => "Error reporting level",
  :description => "Sets PHP Error Reporting in php.ini",
  :default => "E_ALL & ~E_DEPRECATED"

attribute "php/memory_limit",
  :display_name => "PHP Memory limit",
  :description => "Sets Memory Limit",
  :default => "32M"

attribute "php/error_log",
  :display_name => "Error log path",
  :description => "Sets path for Error log",
  :default => "/var/log/php_error.log"

attribute "php/post_max_size",
  :display_name => "Post Max Size",
  :description => "Sets Memory Limit for php",
  :default => "16M"

attribute "php/upload_max_filesize",
  :display_name => "Upload max filesize",
  :description => "Sets Memory Limit for php",
  :default => "16M"

attribute "php/allow_url_fopen",
  :display_name => "Allow url fopen",
  :description => "Sets Memory Limit for php",
  :default => "Off"

attribute "php/date_timezone",
  :display_name => "Date timezone",
  :description => "Sets the timezone",
  :default => "Europe/London"
          
    
    
%w{ubuntu debian}.each do |os|
  supports os
end

%w{centos redhat fedora suse}.each do |os|
  supports os
end