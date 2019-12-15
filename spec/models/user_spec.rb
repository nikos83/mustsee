# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:admin) { create :user, :admin, :confirmed }
  let!(:user) { create :user }
  it { should validate_presence_of(:email) }

  it 'sends an email to admin' do
    expect { AdminNotifierMailer.notify_admin(admin, user).deliver_now }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
