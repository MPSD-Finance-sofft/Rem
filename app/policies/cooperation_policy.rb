class CooperationPolicy < ApplicationPolicy

  def index?
   user.admin?
  end

  def show?
     user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
      user.admin?
  end

  def changes?
      update?
  end

  def uploads?
      show?
  end

  def delete_image?
      update?
  end
end
