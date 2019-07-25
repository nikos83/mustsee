# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  render_views
  let!(:film) { create :film, :cover_img, :film_link }

  # context 'when admin is logged in' do
  #   login_admin
  #   it 'delete attachment' do
  #     expect { delete :destroy, params: { film_link: film.film_link.id } }.to
  # change(ActiveStorage::Attachment, :count).by(1)
  #   end
  # end
end
