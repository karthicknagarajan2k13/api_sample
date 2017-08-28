module Api
  module V1
    # Api base controller
    class ApiController < Api::BaseController
      include TokenHelper
      prepend_before_action :parse_request
      skip_before_action :authenticate_user!
      before_action :auth_user
      before_action :authorize_user

      private

      def authorize_user
        controller = params[:controller]
        action = params[:action]
        permission = Permission.new
        unless permission.allowed?(@user.role.try(:name), controller, action)
          render_failed({ msg: 'Permission denied to access this url' },
                        :unauthorized)
        end
      end
    end # Class end
  end
end
