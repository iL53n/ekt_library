require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:books).through(:posts) }
  it { should have_many :comments }
  it { should have_many :ratings }

  describe 'Methods' do
    let(:book) { create(:book) }
    let(:user) { create(:user) }
    let!(:rating) { create(:rating, book_id: book.id, user_id: user.id, value: '5') }

    it '#voted(book)' do
      expect(user.voted?(book)).to eq true
    end
  end
end
