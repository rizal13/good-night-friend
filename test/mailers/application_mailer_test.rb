# test/mailers/application_mailer_test.rb
require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "ApplicationMailer inherits from ActionMailer::Base" do
    assert ApplicationMailer < ActionMailer::Base, "Check class ApplicationMailer inherit from ActionMailer::Base"
  end
end
