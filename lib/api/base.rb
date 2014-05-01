
class API::Base < Grape::API
	def self.inherited(subclass)
    super
    subclass.instance_eval do
      helpers API::Base::Auth
      helpers API::Base::Util
      version 'v1', :using => :path
      format :json
      default_error_status 400
      default_error_formatter :json
    end
  end

	module Auth
    def authenticate!
      # error!({status: 401, status_code: 'unauthorized'}, 401) unless current_user
    end
  end

  module Util
    def logger
      API::Base.logger
    end

    def server_time
      Time.now.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end