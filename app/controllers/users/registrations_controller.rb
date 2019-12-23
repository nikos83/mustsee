# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      NotificationService.new.registration_info(@user) if @user.persisted?
    end
  end
end
