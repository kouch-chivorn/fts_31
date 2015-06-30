module ControllerMacros
  def signin_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @admin = FactoryGirl.create :admin
    sign_in @admin
  end

  def signin_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create :user
    sign_in user
  end
end
