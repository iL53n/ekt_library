require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_inclusion_of(:title).in_array(%w[booking reading readed wish]) }
  it { should belong_to :book }
  it { should belong_to :user }
end