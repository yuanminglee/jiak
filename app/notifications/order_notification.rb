# To deliver this notification:
#
# OrderNotification.with(post: @post).deliver_later(current_user)
# OrderNotification.with(post: @post).deliver(current_user)
class OrderNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database, format: :to_database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  def to_database
    {
      type: self.class.name,
      params: params
    }
  end

  # Add required params
  #
  param :order

  # Define helper methods to make rendering easier.

  def message
    order = params[:order]
    "New order from #{order.user.name} for #{order.collection_date}: #{order.total_price.format}"
  end

  def url
    order_path(params[:order])
  end
end
