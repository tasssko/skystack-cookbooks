pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-mcrypt"}, "default" => "php5-mcrypt")

package pack do
  action :upgrade
end