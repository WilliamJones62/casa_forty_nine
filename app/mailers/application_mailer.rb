# frozen_string_literal: true

# Mailer code goes here when the customer booking is confirmed
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
