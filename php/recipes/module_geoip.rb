
pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-geoip"}, "default" => "php5-geoip")

package pack do
  action :upgrade
end