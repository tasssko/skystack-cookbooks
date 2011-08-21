pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-imagick"}, "default" => "php5-imagick")

package pack do
  action :upgrade
end