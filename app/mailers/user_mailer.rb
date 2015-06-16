class UserMailer < ApplicationMailer
  
  def email_result user
    @user = user 
    @test = user.tests.last
    @url = test_url @test
    mail to: @user.email, subject: "The Result of Your Test", alert: "Mail sent"

  end
end
