require 'rails_helper'

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
    let!(:post_booking) { create(:post, title: 'booking', active: true, book_id: book_booked.id, user_id: user.id) }

    it '#calculate_rating' do
      book.ratings.create(value: 5, user: (create :user))
      book.ratings.create(value: 3, user: (create :user))
      book.ratings.create(value: 1, user: (create :user))
      expect(book.calculate_rating).to eq(3)
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
