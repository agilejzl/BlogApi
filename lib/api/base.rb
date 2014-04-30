
class API::Base < Grape::API
	def self.inherited(subclass)
    super
    subclass.instance_eval do
      helpers API::Base::Auth
      version 'v1', :using => :path
      format :json
    end
  end


	module Auth
    def authenticate!
      # error!({status: 401, status_code: 'unauthorized'}, 401) unless current_user
    end
  end
end