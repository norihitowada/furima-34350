class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  with_options presence: true do
  validates :nickname
  validates :name_kanji_last
  validates :name_kanji_first
  validates :name_kana_last
  validates :name_kana_first
  validates :birthday

  with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
  validates :name_kanji_last
  validates :name_kanji_first
  end

  with_options format: { with: /\A[ァ-ヶ一]+\z/, message: 'カタカナを使用してください' } do
  validates :name_kana_last
  validates :name_kana_first
  end


  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  end

end
