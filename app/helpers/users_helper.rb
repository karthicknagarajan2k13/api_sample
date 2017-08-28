module UsersHelper
  def get_user_name_or_email(user)
    user.name ? user.name : user.email
  end
end
