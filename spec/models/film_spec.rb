# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  let!(:film) { create :film, :cover_img }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }

  context 'when attachments type is correct' do
    it 'is valid with correct cover' do
      build(:film, :cover_img).should be_valid
    end

    it 'is valid with correct film' do
      build(:film, :cover_img, :film_link).should be_valid
    end

    it 'it is valid with film nil' do
      build(:film, :cover_img, :film_link_nil).should be_valid
    end
  end

  context 'when attachments type is not correct' do
    it 'is invalid with wrong film' do
      build(:film, :cover_img, :film_link_wrong).should_not be_valid
    end

    it 'is invalid with wrong cover' do
      build(:film, :cover_img_wrong).should_not be_valid
    end

    it 'should be invalid without cover' do
      build(:film, :cover_img_nil).should_not be_valid
    end

    it 'should be invalid with wrong film and cover' do
      build(:film, :cover_img_nil, :film_link_wrong).should_not be_valid
    end
  end
end
