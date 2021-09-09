# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :search, :search_form, :to => :read
    # endpoints from channel_statistics_controller for graphs
    alias_action :last_week, :today, :current, :current_sent, :to => :read

    @user = user
    if @user.nil?
      can :read, Home
    elsif @user.is_admin?
      can :manage, :all
      cannot [:update, :destroy], :roles, :ro => :true
    elsif @user.authorities.any? || @user.group_authorities.any?
      can :read, :all
    else
      can :read, Home
    end

  end
end
