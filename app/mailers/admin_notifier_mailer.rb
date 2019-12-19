# frozen_string_literal: true

class AdminNotifierMailer < ApplicationMailer
  def notify_admin(admin, user)
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: 'Notification')
  end
end
