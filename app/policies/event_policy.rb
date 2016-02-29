class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? or user.manager?
        scope.all
      else
        #scope.where(published: true)
        scope.joins(:event_users).where(["event_users.role = ? AND event_users.user_id = ? OR published = ?", 1, user, 'true']).uniq
      end
    end
  end

  def permitted_attributes
    if user.admin? or record.event_users.find_by_user_id(user).organizador?
      [:code, :name, :date, :address, :description,
        :release_sign_up, :published, image_attributes: [:image]]
    else
      []
    end
  end

  def index?
    true
  end

  def show?
    user.admin? or user.manager? or record.published or record.is_the_user? user, :organizador
  end

  def edit?
    user.admin? or record.is_the_user? user, :organizador
  end

  def update?
    user.admin? or record.is_the_user? user, :organizador
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

  def event_subscribe?
    record.release_sign_up?
  end
end
