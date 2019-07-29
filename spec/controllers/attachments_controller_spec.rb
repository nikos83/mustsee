# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  render_views
  let!(:film) { create :film, :cover_img, :film_link }

  describe 'admin is logged in' do
    login_admin

    context 'when nothing is done' do
      it 'returns 2 attachments' do
        expect(ActiveStorage::Attachment.count).to eq(2)
      end
    end

    context 'when one attachment is deleted' do
      before { delete :destroy, params: { id: film.film_link.id, film_id: film.id } }

      it 'returns 1 attachment' do
        expect(ActiveStorage::Attachment.count).to eq(1)
      end
    end
  end
end
