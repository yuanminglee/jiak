class LineItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.order.restaurant.user == user || record.order.user == user
  end

  def destroy?
    record.order.restaurant.user == user || record.order.user == user
  end
end
