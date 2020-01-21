# frozen_string_literal: true

class OmdbController < ApplicationController
  def index
    @film = OmdbService.new(params[:search], params[:year])
  end

  def search; end
end
