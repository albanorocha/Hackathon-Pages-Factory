class TeamPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  #def permitted_attributes
  #  if user.admin? or record.event_users.find_by_user_id(user).organizador?
  #    [:code, :name, :date, :address, :description,
  #      :release_sign_up, :published, image_attributes: [:image]]
  #  else
  #    []
  #  end
  #end

  def index?
    user.admin? or Pundit.policy!(user, record.event).show?
  end

  def show?
    user.admin? or
    record.is_the_user_there? user or
    record.event.is_the_user? user, :organizador
  end

  def edit?
    user.admin? or
    record.is_the_user_there? user or
    record.event.is_the_user? user, :organizador
  end

  def update?
    user.admin? or
    record.is_the_user_there? user or
    record.event.is_the_user? user, :organizador
  end

  def new?
    Pundit.policy!(user, record.event).show?
  end

  def create?
    Pundit.policy!(user, record.event).show?
  end

  def destroy?
    user.admin? or
    record.is_the_user_there? user or
    record.event.is_the_user? user, :organizador
  end
end
