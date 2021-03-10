class PagesController < ApplicationController
  def home
    @disable_container = true

    if user_signed_in?
      redirect_to restaurants_path
    else
      render :home
    end
  end
end
