FactoryBot.define do
  factory :purchaserecord_address do
    zip_code { '123-4567' }
    prefecture_id { 2 }
    city { '中央区' }
    street_number { '1-1' }
    building { '東京ハイツ' }
    phone_number { '11111111111' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
