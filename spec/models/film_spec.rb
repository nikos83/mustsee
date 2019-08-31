# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Film, type: :model do
  let!(:film) { create :film, :cover_img }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }

  context 'attachemt check for cover' do
    it 'should be valid with correct type' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'),
                                              'image/jpg')).should be_valid
    end

    it 'should be invalid with wrong type of film_link' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'),
                                              'image/jpg'),
               film_link: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'),
                                              'image/jpg')).should_not be_valid
    end

    it 'should valid with good film_link' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'),
                                              'image/jpg'),
               film_link: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.mp4'),
                                              'image/jpg')).should be_valid
    end

    it 'should valid without film_link' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'),
                                              'image/jpg')).should be_valid
    end

    it 'should be invalid with not correct type' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: fixture_file_upload(Rails.root.join('spec', 'assets', 'test.txt'))).should_not be_valid
    end

    it 'should be invalid without cover' do
      Film.new(title: 'First title',
               description: 'test',
               cover_img: nil).should_not be_valid
    end
  end
end
