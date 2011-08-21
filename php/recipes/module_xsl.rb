
pack = value_for_platform([ "centos", "redhat", "fedora", "suse" ] => {"default" => "php-xsl"}, "default" => "php5-xsl")

package pack do
  action :upgrade
end