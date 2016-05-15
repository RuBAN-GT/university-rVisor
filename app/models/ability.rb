class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :super_admin
      can :access, :rails_admin
      can :dashboard
    end

    unless user.id.nil?
      can :manage, :all
    end
  end
end
