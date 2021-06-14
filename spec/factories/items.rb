FactoryBot.define do
  factory :item do
    name                  { Faker::Name.initials(number: 2) }
    explanation           { 'テスト' }
    category_id           { '3' }
    condition_id          { '3' }
    delivery_cost_id      { '3' }
    prefecture_id         { '3' }
    day_id                { '3' }
    price                 { '1000' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end


  end
end

