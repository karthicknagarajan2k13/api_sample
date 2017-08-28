module ApplicationHelper
	def resource_name
		:user
	end

	def resource_class 
		User 
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

  def get_message_heading
    if current_user.admin?
      'All Stories'
    else
      'Your Story'
    end
  end

end
