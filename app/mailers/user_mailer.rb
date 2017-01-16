class UserMailer < ApplicationMailer
  def send_enabled_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Pixel Technologies!!!")
  end

  def send_new_user_message(user)
    @user = user
    mail(:to => 'ben.suryn@rnd.designcom.com.au', :subject => "New User created please review and enable.")
  end
end