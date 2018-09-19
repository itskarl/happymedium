class ChargesController < ApplicationController
  def new
  render layout: "application"
   end

  def index
    @charges = Stripe::Charge.list
  end

  def create

    render layout: "application"
    # Amount in cents
    @amount = params[:dollars]
    # @current_email = current_user.email if current_user

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
      # receipt_email: @current_email
    )



  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end



end
