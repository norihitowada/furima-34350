class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image

  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :Prefecture
  belongs_to :day

  validates :name, :explanation, :price, :image, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  
  with_options numericality: { other_than: 1 } do
  validates :category_id
  validates :condition_id
  validates :delivery_cost_id
  validates :prefecture_id
  validates :day_id
  end
  
end
