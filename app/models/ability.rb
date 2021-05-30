# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :search, :to => :read
    alias_action :search_form, :to => :read

    @user = user
    if @user.nil?
      can :read, Home
    elsif @user.is_admin?
      can :manage, :all
      cannot [:update, :destroy], :roles, :ro => :true
    else
      can :read, :all
    end

  end
end
