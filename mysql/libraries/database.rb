begin
  require 'mysql'
rescue LoadError
  Chef::Log.warn("Missing gem 'mysql'")
end

module Opscode
  module Mysql
    module Database
      def db
        @@db ||= ::Mysql.new new_resource.host, new_resource.root_username, new_resource.root_password
      end
    end
  end
end
