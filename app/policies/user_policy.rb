class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record == user
  end

  def earnings?
    record == user && user.is_chef
  end

  def edit?
    record == user
  end

end
