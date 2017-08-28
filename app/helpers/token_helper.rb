module TokenHelper
  def parse_request
    api_token = Rails.application.secrets.api_v1
    token = request.headers['Api-Token']
    unless token.present? && token == api_token
      render_failed(msg: 'Invalid API Token.')
    end
  end

  def auth_user
    @auth_token = request.headers['Auth-Token']
    if @auth_token.present? && User.verify_token(@auth_token)
      @user = User.token_user(@auth_token)
    else
      render_failed(msg: 'Invalid Auth Token or Expired.')
    end
  end
end