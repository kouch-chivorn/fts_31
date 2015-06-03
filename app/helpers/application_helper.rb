module ApplicationHelper
  def resource_name
    :user
    :admin
  end

  def resource
    @resource ||= User.new || Admin.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user] || Devise.mappings[:admin]
  end

  def shorten str
    str
  end
end
