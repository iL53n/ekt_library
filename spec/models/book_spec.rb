require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
  it { should validate_presence_of :description }
  it { should validate_presence_of :image }
  it { should validate_presence_of :status }
  it { should have_and_belong_to_many :categories }
  it { should belong_to(:user).optional }
  it { should have_many :readings }
  it { should have_many :wishes }
end
