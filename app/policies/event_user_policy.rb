class EventUserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    if user.admin? or user.event_users.find_by_event_id(record.event).organizador?
      [:user]
    else
      []
    end
  end

  def index?
    user.admin? or Pundit.policy!(user, record.first.event).show?
  end

  def new?
    user.admin? or record.event.is_the_user? user, :organizador
  end

  def new_manager?
    user.admin? or record.event.is_the_user? user, :organizador
  end

  def create_manager?
    user.admin? or record.event.is_the_user? user, :organizador
  end

  def create?
    user.admin? or record.event.is_the_user? user, :organizador
  end

  def destroy?
    user.admin? or record.event.is_the_user? user, :organizador
  end
end
