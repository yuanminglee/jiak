class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    user.is_chef
  end

  def create?
    user.is_chef
  end

  def edit?
    user.is_chef && record.user == user
  end

  def update?
    user.is_chef && record.user == user
  end

  def destroy?
    user.is_chef && record.user == user
  end
end
