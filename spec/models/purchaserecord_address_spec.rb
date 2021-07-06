require 'rails_helper'

RSpec.describe PurchaserecordAddress, type: :model do
  before do
    @purchaserecord_address = FactoryBot.build(:purchaserecord_address)
  end

  describe '商品購入機能' do
    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchaserecord_address).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @purchaserecord_address.building = ''
        expect(@purchaserecord_address).to be_valid
      end
    end
    
    context '購入できないとき' do
      it 'zip_copeが空では登録できない' do
        @purchaserecord_address.zip_code = ''
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it 'zip_copeが半角のハイフンを含んでいないと登録できない' do
        @purchaserecord_address.zip_code = '1234567'
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end
      it 'prefectureを選択していないと登録できない' do
        @purchaserecord_address.prefecture_id = ''
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @purchaserecord_address.city = ''
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("City can't be blank")
      end
      it 'street_numberが空では登録できない' do
        @purchaserecord_address.street_number = ''
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Street number can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @purchaserecord_address.phone_number = ''
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが12桁以上では登録できない' do
        @purchaserecord_address.phone_number = '111111111111'
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Phone number must be less than or equal to 99999999999")
      end
      it 'Tokenが空では登録できない' do
        @purchaserecord_address.token = nil
        @purchaserecord_address.valid?
        expect(@purchaserecord_address.errors.full_messages).to include("Token can't be blank")
      end
      end
    end
end
