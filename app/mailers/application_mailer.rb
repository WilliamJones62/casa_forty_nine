# frozen_string_literal: true

# This class contains application mailer logic
class ApplicationMailer < ActionMailer::Base
  default from: 'williamjones120862@gmail.com'
  layout 'mailer'
end
