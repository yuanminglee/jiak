class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.all
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.mark_as_read!
    redirect_to root_path, notice: "Notification read"
  end
end
