# frozen_string_literal: true

class NotificationService
  def registration_info(user)
    @admins = User.where(admin: true)
    @admins.each { |admin| AdminNotifierMailer.notify_admin(admin, user).deliver_later }
  end
end
