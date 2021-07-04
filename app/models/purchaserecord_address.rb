class PurchaserecordAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :street_number, :building, :phone_number

  with_options presence: true do
  validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, numericality: { other_than: 1 } 
  validates :city
  validates :street_number
  validates :phone_number, numericality: { less_than_or_equal_to: 99999999999 }
  end

  def save
  purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)

  Address.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, street_number: street_number, building: building, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
  
end
