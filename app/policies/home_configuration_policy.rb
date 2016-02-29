class HomeConfigurationPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.first
      end
    end
  end


  def index?
    user.admin?
  end

  def update?
    user.admin?
  end
end
