module ProphentsHelper
  def ger_request_user(prophent)
    user_name = prophent.user_request.user
    user_name ? user_name.name : user_name.email
  end
end
