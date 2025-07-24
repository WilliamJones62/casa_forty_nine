# frozen_string_literal: true

# This class contains Review mailer logic
class ReviewMailer < ApplicationMailer
  helper :application

  def create_review(user, review)
    @user = user
    @review = review
    to = ['williamjones120862@gmail.com', 'erichbriehl@gmail.com']
    mail(
      to: to,
      subject: 'Casa 49 New Review'
    )
  end

  def update_review(user, review)
    @user = user
    @review = review
    to = ['williamjones120862@gmail.com', 'erichbriehl@gmail.com']
    mail(
      to: to,
      subject: 'Casa 49 Changed Review'
    )
  end
end
