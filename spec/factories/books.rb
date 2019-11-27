FactoryBot.define do
  sequence :title do |n|
    "title_#{n}"
  end

  factory :book do
    title
    author { 'Pushkin' }
    description { 'description description description ' }
    image { 'image' }
    status { 'in_stock' }
  end
end