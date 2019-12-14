# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      @admin = User.where(admin: true).first
      AdminNotifierMailer.notify_admin(@admin, @user).deliver_later if @user.persisted?
    end
  end
end
