class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :super_admin
      can :manage, :all
      can :access, :ckeditor
    end
  end
end
