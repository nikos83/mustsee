# frozen_string_literal: true

class AdminNotifierMailer < ApplicationMailer
  def notify_admin(admin, user)
    @user = user
    @admin = admin
    sleep(5) # this emulates long email sending, do not remove
    mail(to: @admin.email, subject: 'Notification')
  end
end
