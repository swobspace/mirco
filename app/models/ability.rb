# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def initialize(user)
    alias_action :search, :search_form, to: :read
    # endpoints from channel_statistics_controller for graphs
    alias_action :last_week, :last_month, :today, :current, :current_sent, to: :read
    alias_action :sindex, :queued, :problems, to: :read

    @user = user
    if @user.nil?
      can :read, Home
      # neccessary for home page
      can [:queued, :problems], ChannelStatistic
      can [:sindex], Server
      can [:read], Note, type: 'acknowledge'
    elsif @user.is_admin?
      can :manage, :all
      cannot %i[update destroy], :roles, ro: true
    elsif @user.role?(:manager)
      can [:read, :navigate], :all
      can :manage, [Note], user_id: @user.id
    elsif @user.authorities.any? || @user.group_authorities.any?
      can :read, [ Alert, ChannelCounter, Channel, ChannelStatistic, Home,
                   Host, InterfaceConnector, Location, Note, Server,
                   SoftwareConnection, SoftwareGroup, SoftwareInterface,
                   Software ]
      can :navigate, :all
    else
      can :read, Home
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
