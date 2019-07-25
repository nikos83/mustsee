# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :find_film

  def destroy
    @film_link = ActiveStorage::Attachment.find(params[:id])
    @film_link.purge
    redirect_back(fallback_location: films_path)
  end

  private

  def find_film
    @film = Film.friendly.find(params[:film_id])
  end
end
