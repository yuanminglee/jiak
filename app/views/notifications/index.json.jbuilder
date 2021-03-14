json.array! @notifications do |notification|
  json.order notification.params[:order]
  json.notifiable do
    json.type "An order"
  end
end
