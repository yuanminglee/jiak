class UsersController < ApplicationController
  def show
    @user = current_user

    authorize @user
  end

  def earnings
    @user = current_user
    authorize @user

    @orders = current_user.restaurants.map do |restaurant|
      restaurant.orders
    end.flatten.reject { |order| order.status.in? ["Draft", "Cancelled"] }

    @earnings = @orders.sum(&:total_price)
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    @user.update(params[:users])
    redirect_to user_profile_path(@user)
  end

end
