class OrderMailer < ApplicationMailer
  def order_confirmation_email
    @order = params[:order]
    @code = params[:code]
    
    
    mail(to: 'juzjaelyn@gmail.com', subject: "Your order is confirmed!")
  end
end
