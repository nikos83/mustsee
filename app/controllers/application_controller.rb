# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def redirect_unauthorized_user
    redirect_to films_url, notice: 'Error! You are not permitted' unless current_user.try(:admin?)
  end
end
