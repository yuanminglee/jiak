class OrderMailer < ApplicationMailer
  def order_confirmation_email
    @order = params[:order]
    mail(to: 'primaulia@gmail.com', subject: "Your order is confirmed!")
  end
end
