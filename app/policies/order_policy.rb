class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    my_restaurant_or_my_order
  end

  def create?
    true
  end

  def edit?
    my_restaurant_or_my_order
  end

  def update?
    my_restaurant_or_my_order
  end

  def cancel?
    my_restaurant_or_my_order
  end

  def confirm?
    my_restaurant_or_my_order
  end

  private

  def my_restaurant_or_my_order
    if user.is_chef
      record.restaurant.user == user
    else
      record.user == user
    end
  end
end
