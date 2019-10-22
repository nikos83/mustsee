# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review) { create :review }
  it { should validate_presence_of(:rating) }
  it { should_not allow_value('').for(:rating) }
  it { should_not allow_value(nil).for(:rating) }
  it { should belong_to(:user) }
  it { should belong_to(:film) }
  subject { FactoryBot.build(:review) }
  it {
    should validate_uniqueness_of(:user_id)
      .scoped_to(:film_id).with_message("You're only allowed to have one comment per film.")
  }
end
