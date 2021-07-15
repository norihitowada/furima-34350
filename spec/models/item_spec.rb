require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it '商品名が１文字以上で登録できる' do
        @item.name = 'a'
        expect(@item).to be_valid
      end
      it '商品説明が１文字以上で登録できる' do
        @item.explanation = 'a'
        expect(@item).to be_valid
      end
      it 'カテゴリーはidが1以外で登録できる' do
        @item.category_id = 5
        expect(@item).to be_valid
      end
      it '商品の状態はidが１以外で登録できる' do
        @item.condition_id = 3
        expect(@item).to be_valid
      end
      it '配送料の負担はidが１以外で登録できる' do
        @item.delivery_cost_id = 3
        expect(@item).to be_valid
      end
      it '発送元の地域はidが１以外で登録できる' do
        @item.prefecture_id = 3
        expect(@item).to be_valid
      end
      it '発送までの日数はidが１以外で登録できる' do
        @item.day_id = 3
        expect(@item).to be_valid
      end
      it '販売価格はidが300から9,999,999の範囲で登録できる' do
        @item.prefecture_id = 10_000
        expect(@item).to be_valid
      end
      context '出品できないとき' do
        it 'nameが空では登録できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end
        it '商品説明が空では登録できない' do
          @item.explanation = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end
        it 'カテゴリーが1では登録できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
        end
        it '商品説明が1では登録できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の状態は1以外の値にしてください')
        end
        it '配送料負担が1では登録できない' do
          @item.delivery_cost_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
        end
        it '発送元の地域が1では登録できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
        end
        it '発送までの日数が1では登録できない' do
          @item.day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
        end
        it '販売価格が空では登録できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("価格を入力してください")
        end
        it '販売価格が半角数字以外では登録できない' do
          @item.price = 'あ２'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は数値で入力してください')
        end
        it '販売価格が300未満では登録できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
        end
        it '販売価格が10,000,000以上では登録できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
        end
        it '販売価格が半角英数字混合では登録できない' do
          @item.price = '10a'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は数値で入力してください')
        end
        it '販売価格が半角英語だけでは登録できない' do
          @item.price = 'aaa'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は数値で入力してください')
        end
        it 'userが紐づいていないと登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Userを入力してください')
        end
      end
    end
  end
end
