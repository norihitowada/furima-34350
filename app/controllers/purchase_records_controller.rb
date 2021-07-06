class PurchaseRecordsController < ApplicationController
  def index
     @item = Item.find(params[:item_id])
     @purchase_record = PurchaserecordAddress.new
  end

  def create
    @purchase_record = PurchaserecordAddress.new(purchase_params)
    if @purchase_record.valid?
      pay_item
      @purchase_record.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :'index'
    end
  end

 private

 def purchase_params
    params.require(:purchaserecord_address).permit(:zip_code, :prefecture_id, :city, :street_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
 end

 def pay_item
 Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
 Payjp::Charge.create(
   amount: Item.find(params[:item_id]).price,  # 商品の値段
   card: purchase_params[:token],    # カードトークン
   currency: 'jpy'                 # 通貨の種類（日本円）
 )
end





end
