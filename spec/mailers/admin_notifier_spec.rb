# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminNotifierMailer, type: :mailer do
  describe 'admin information' do
    let(:user) { create :user, :confirmed }
    let(:admin) { create :user, :admin, :confirmed }
    let(:mail) { AdminNotifierMailer.notify_admin(admin, user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Notification')
    end

    it 'renders the admin email' do
      expect(mail.to).to eq([admin.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([Rails.application.credentials.dig(:sendgrid, :from)])
    end

    it 'assigns user email' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
