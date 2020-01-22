FactoryBot.define do
  sequence :title do |n|
    "title_#{n}"
  end

  factory :book do
    title
    author { 'Pushkin' }
    description { 'description description description ' }
    status { 'available' }

    # trait :add_file do
    #   files { fixture_file_upload(Rails.root.join('spec', 'rails_helper.rb'), 'rails_helper.rb') }
    # end
  end
end