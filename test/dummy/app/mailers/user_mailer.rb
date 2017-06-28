class UserMailer < ApplicationMailer

  def invite(recipient)
    mail to: recipient
  end

end
