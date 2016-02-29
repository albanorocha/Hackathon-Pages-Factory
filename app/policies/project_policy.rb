class ProjectPolicy < ApplicationPolicy

  def edit?
    user.admin? or
    record.team.is_the_user_there? user or
    record.team.event.is_the_user? user, :organizador
  end

  def update?
    user.admin? or
    record.team.is_the_user_there? user or
    record.team.event.is_the_user? user, :organizador
  end

  def new?
    user.admin? or
    record.team.is_the_user_there? user or
    record.team.event.is_the_user? user, :organizador
  end

  def create?
    user.admin? or
    record.team.is_the_user_there? user or
    record.team.event.is_the_user? user, :organizador
  end

  def destroy?
    user.admin? or
    record.team.is_the_user_there? user or
    record.team.event.is_the_user? user, :organizador
  end
end
