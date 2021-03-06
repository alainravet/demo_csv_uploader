
class TransfersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_filter :authorize, only: [:new, :create, :index]

  def new
    if current_user.balance_in_cents == 0
      redirect_to current_user, alert: "Your balance is 0; you cannot transfer any money"
    else
      @transfer = Transfer.new(origin_id: current_user.id)
    end

  end

  def create
    source = Account.find_by_id(params[:transfer][:origin_id])
    dest   = Account.find_by_id(params[:transfer][:destination_id])
    amount = params[:transfer][:amount].presence.try(:to_f)
    @transfer =Transfer.new(origin: source, destination: dest, amount: amount)
    if @transfer.save
      redirect_to current_user, notice: "#{number_to_currency(@transfer.amount)} transferred."
    else
      render action: 'new'
    end
  end
end
