class PaymentsController < ApplicationController

  def new
    @item = Item.find_by(params[:item_id])
    @payment = Payment.new
  end

  def create
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    if Payjp::Charge.create(amount: params[:payment][:amount], customer:  current_user.payjp_id, currency: 'jpy')
      if Payment.create(create_params)
        redirect_to group_item_path(params[:group_id], params[:item_id])
      end
    else
      render :new,notice: '入力に不備があります'
    end
  end

  private
  def create_params
    params.require(:payment).permit(:amount).merge({user_id: current_user.id, item_id: params[:item_id]})
  end
end

