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

    @earnings_money = @orders.sum(&:total_price)

    if @earnings_money.zero?
      @earnings = "$0"
    else
      @earnings = @earnings_money.format
    end

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
