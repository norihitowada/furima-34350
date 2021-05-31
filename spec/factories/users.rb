FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '111111a' }
    password_confirmation { password }
    name_kanji_last       { '佐藤' }
    name_kanji_first      { '太郎' }
    name_kana_last        { 'サトウ' }
    name_kana_first       { 'タロウ' }
    birthday              { '1930-01-01' }
  end
end
