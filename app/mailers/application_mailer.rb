# frozen_string_literal: true

# This is the base mailer class from which all other mailer classes in the application inherit.
# It provides default settings and configurations for sending emails.
class ApplicationMailer < ActionMailer::Base
  default from: 'from_GunnerGuides@example.com'
  layout 'mailer'
end
