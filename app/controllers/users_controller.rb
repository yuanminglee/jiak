class UsersController < ApplicationController
  def show
    @user = current_user

    authorize @user
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
