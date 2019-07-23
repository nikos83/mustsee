# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  let!(:film) { create :film, :cover_img }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }
end
