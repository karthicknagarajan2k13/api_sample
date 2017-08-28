# User Permission class
class Permission
  include ActiveModel::Model

  def initialize(attributes = {})
    super
    @permissions = Rails.configuration.app_data['Permissions']
  end

  def allowed?(role, controller, action)
    @controller = controller
    @action = action
    if role.nil?
      false
    else
      match?(role.downcase)
    end
  end

  def persisted?
    false
  end

  private

  def match?(user)
    if @permissions[user].key?(@controller)
      c = @permissions[user][@controller]
      c.first == '*' || c.include?(@action)
    else
      false
    end
  end
end #
