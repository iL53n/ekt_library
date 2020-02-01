FactoryBot.define do
  sequence :end_date do |n|
    "2020-01-#{n}"
  end

  factory :post do
    book
    user
    title { 'reading' }
    end_date
  end
end
