pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-xdebug"}, "default" => "php5-xdebug")

package pack do
  action :upgrade
end