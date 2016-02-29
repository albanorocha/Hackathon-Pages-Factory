class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def permitted_attributes
    if user.admin?
      [:name, :email, :password, :role]
    else
      [:name, :email, :password]
    end
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? or record == user
  end

  def edit?
    user.admin? or record == user
  end

  def update?
    user.admin? or record == user
  end

  def edit_password?
    user.admin? or record == user
  end

  def update_password?
    user.admin? or record == user
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def equipes?
    user.admin? or record == user
  end
end
