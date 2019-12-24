require 'rails_helper'

RSpec.describe Wish, type: :model do
  it { should belong_to :book }
  it { should belong_to :user }
end
