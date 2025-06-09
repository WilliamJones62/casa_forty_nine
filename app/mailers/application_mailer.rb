# frozen_string_literal: true

# This class contains application mailer logic
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
