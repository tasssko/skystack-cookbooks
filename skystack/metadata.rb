maintainer       "Skystack Limited."
maintainer_email "support@skystack.com"
license          "Apache 2.0"
description      "Configures a variety of applications defined from Skystack"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
recipe           "skystack::default", "This recipe acts as a front controller for loading configurations in a organised way."
recipe           "skystack::firewall", "Automatically locks down a server during the bootrap process."
recipe           "skystack::apache2", "Sets up a web server and virtual hosting environment."
recipe           "skystack::script", "Runs ad hoc scripts during the build process."
recipe           "skystack::mysql", "Sets up MySQL."
recipe           "skystack::mongodb", "Sets up MongoDB."
%w{ apache2 php }.each do |cb|
  depends cb
end
