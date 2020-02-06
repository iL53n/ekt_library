require 'rails_helper'

RSpec.describe FilterBooks do
  let(:user) { create(:user) }
  let!(:post) { create(:post, title: 'reading', user: user, active: true) }
  let!(:reading_book) { create(:book, posts: [post]) }
  let(:books) { create_list(:book, 2) }
  # let(:params) do
  #   { :filter => 'all' }
  # end
  before { books << reading_book }

  describe 'return books' do
    context 'all' do
      let(:service) { FilterBooks.new(books, user, params: { :filter => 'all' }) }
      it 'return all books array' do
        expect(service.call('')).to match_array(books)
      end
    end

    context 'reading' do

      let!(:service) { FilterBooks.new(books, user, params: { :filter => 'reading' }) }
      it 'return all books array' do
        expect(service.call('')).to match_array(reading_book)
      end
    end
  end
end

