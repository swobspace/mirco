# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def initialize(user)
    alias_action :search, :search_form, to: :read
    # endpoints from channel_statistics_controller for graphs
    alias_action :last_week, :last_month, :today, :current, :current_sent, to: :read

    @user = user
    if @user.nil?
      can :read, Home
    elsif @user.is_admin?
      can :manage, :all
      cannot %i[update destroy], :roles, ro: true
    elsif @user.role?(:manager)
      can :read, :all
      can :manage, [Note], user_id: @user.id
    elsif @user.authorities.any? || @user.group_authorities.any?
      can :read, :all
    else
      can :read, Home
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
