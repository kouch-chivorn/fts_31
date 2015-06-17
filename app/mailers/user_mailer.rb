class UserMailer < ApplicationMailer
  
  def email_result user_id
    @user = User.find_by id: user_id
    @test = @user.tests.last
    @url = test_url @test
    mail to: @user.email, subject: "The Result of Your Test", alert: "Mail sent"
  end
end
