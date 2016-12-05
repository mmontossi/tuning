require 'test_helper'

class MailerTest < ActionMailer::TestCase

  test 'normalization' do
    email = UserMailer.invite('test@mail.com')
    assert_equal(
      "Hi there,\n\nPlease come check our website!\n\n-- Signature\n",
      email.body.to_s
    )
  end

end
