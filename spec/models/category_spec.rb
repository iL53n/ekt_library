# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of :title }
  it { should have_and_belong_to_many :books }
end
