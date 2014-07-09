ActiveMerchant::Billing::Base.mode = :test

class PurchasesController < ApplicationController
  def create
    gateway = ActiveMerchant::Billing::SkipJackGateway.new(:login => "<login>", :password => "<password>")

    # TODO this would come from the customer or form
    options = {
      :email => 'None',
      :billing_address => {
        :address1 => 'None', :zip => '00000', :city => 'None',
        :state => 'XX', :phone => '0000000000'
      },
      :order_id => 1
    }

    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => params[:ccn],
        :month      => params[:expm],
        :year       => params[:expy],
        :first_name => params[:firstn],
        :last_name  => params[:lastn] 
      )

    # TODO the amount should come from the purchased item model
    authorize_response = gateway.authorize(100, credit_card, options)

    render plain: "Response: #{authorize_response.message}\n\n\nDetails: #{authorize_response.inspect}"
  end
end
