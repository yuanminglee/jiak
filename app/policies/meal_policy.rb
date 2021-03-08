class MealPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.is_chef && record.restaurant.user == user
  end

  def create?
    user.is_chef && record.restaurant.user == user
  end

  def edit?
    user.is_chef && record.restaurant.user == user
  end

  def update?
    user.is_chef && record.restaurant.user == user
  end
end
