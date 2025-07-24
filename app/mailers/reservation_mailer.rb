# frozen_string_literal: true

# This class contains Reservation mailer logic
class ReservationMailer < ApplicationMailer
  helper :application

  def confirm_reservation(user, reservation)
    @user = user
    @reservation = reservation
    # bcc = ["williamjones120862@gmail.com", "erichbriehl@gmail.com"]
    bcc = ['williamjones120862@gmail.com']
    mail(
      to: user.email,
      bcc: bcc,
      subject: 'Casa 49 Reservation Confirmation'
    )
  end
end
