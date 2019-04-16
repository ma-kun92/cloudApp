class PaymentsController < ApplicationController

  def new
    @project = Project.find_by(params[:project_id])
    @payment = Payment.new
  end

  def create
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    if Payjp::Charge.create(amount: params[:payment][:amount], customer:  current_user.payjp_id, currency: 'jpy')
      if Payment.create(create_params)
        redirect_to group_project_path(params[:group_id], params[:project_id]),notice: '◉入金が完了しました!'
      end
    else
      render :new,notice: '入力に不備があります'
    end
  end

  private
  def create_params
    params.require(:payment).permit(:amount).merge({user_id: current_user.id, project_id: params[:project_id]})
  end
end

