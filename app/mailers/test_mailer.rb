class TestMailer < ActionMailer::Base

  default :from => "odraudelp@gmail.com"

  def welcome_email
    mail(:to => "testmail@mymailaddress.com", :subject => "Test mail", :body => "Test mail body")
  end
end

TestMailer.welcome_email.deliver
