module Api
  module V1
    module Users
      class SessionsController < Devise::RegistrationsController
        include TokenHelper, JsonRenderHelper
        before_action :parse_request
        before_action :auth_user, only: [:sign_out]
        skip_before_action :authenticate_user!, only: [:create, :sign_out]
        skip_before_action :verify_authenticity_token

        def create
          @user = User.find_by_email(params[:user][:email])
          if @user && @user.valid_password?(params[:user][:password])
            render_success(msg: 'Login Success',
                         success: true,
                         role: @user.role.try(:name),
                         auth_token: @user.generate_auth_token)
          else
            render_failed(success: false, errors: ['Invalid Username or Password'])
          end
        end
      end
    end
  end
end