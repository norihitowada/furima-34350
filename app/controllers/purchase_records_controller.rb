class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :confirmation
  before_action :move
  before_action :purchase, only: [:index, :create]


  def index
    @purchase_record = PurchaserecordAddress.new
  end

  def create
    @purchase_record = PurchaserecordAddress.new(purchase_params)
    if @purchase_record.valid?
      pay_item
      @purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchaserecord_address).permit(:zip_code, :prefecture_id, :city, :street_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def confirmation
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
  end

  def move
    redirect_to root_path if @item.purchase_record.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,  # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
