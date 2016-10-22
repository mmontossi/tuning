class UserMailer < ActionMailer::Base

  def invite(recipient)
    mail to: recipient
  end

end
