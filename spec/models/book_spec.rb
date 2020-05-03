# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
  it { should validate_presence_of :description }
  it { should validate_presence_of :status }
  it { should have_and_belong_to_many :categories }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:users).through(:posts) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:ratings).dependent(:destroy) }

  it 'has one attached files' do
    expect(Book.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  describe 'Methods' do
    let(:book) { create(:book) }
    let(:book_booked) { create(:book) }
    let(:user) { create(:user) }
    let!(:post_booking) do
      create(:post, title: 'booking',
                    active: true,
                    book_id: book_booked.id,
                    user_id: user.id)
    end

    it '#calculate_rating' do
      1.upto(3) { |num| create(:rating, value: num, book: book) }
      expect(book.calculate_rating).to eq(2)
    end

    it '#calculate_readed' do
      5.times { create(:post, :readed, book: book) }
      expect(book.calculate_readed).to eq(5)
    end

    it '#calculate_commented' do
      5.times { create(:comment, book: book) }
      expect(book.calculate_commented).to eq(5)
    end

    it '#available?' do
      expect(book.available?).to eq true
      expect(book_booked.available?).to eq false
    end

    it '#active_user' do
      expect(book_booked.active_user).to eq user
    end

    it '#active_post' do
      expect(book_booked.active_post).to eq post_booking
    end

    it '#close_active_post' do
      expect(book_booked.active_post).to eq post_booking
      book_booked.close_active_post
      expect(book_booked.available?).to eq true
    end
  end
end
# rubocop:enable Metrics/BlockLength
