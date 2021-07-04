class PurchaseRecordsController < ApplicationController
  def index
     @item = Item.find(params[:item_id])
     @purchase_record = PurchaserecordAddress.new
  end

  def create
    @purchase_record = PurchaserecordAddress.new(purchase_params)
    if @purchase_record.valid?
      @purchase_record.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :'index'
    end
  end

 private

 def purchase_params
    params.require(:purchaserecord_address).permit(:zip_code, :prefecture_id, :city, :street_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
 end

end
