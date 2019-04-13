class CardsController < ApplicationController
  def new

  end

  def create
    binding.pry
    token = params[:token]
      # payjpの機能を使用するときに必要なapi_key
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    customer = Payjp::Customer.create(description: 'test',card: token)
    current_user.payjp_id = customer.id
    if current_user.save
      redirect_to root_path
    else
      render :new, notice: '入力内容に間違いがあります'
    end
  end

  def show

  end

  def destroy
    payjp_id = current_user.payjp_id
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    customer = Payjp::Customer.retrieve(payjp_id)
    binding.pry
    card = customer.cards.retrieve(customer.cards.data[0].id)
    if card.delete
      redirect_to root_path
    end

  end

end
