# frozen_string_literal: true

class Connections::ButtonComponent < ViewComponent::Base
  def initialize(filter:, alert:, label:)
    @filter = filter
    @relation = Connections::Query.new(SoftwareConnection.all, filter).all
    @alert = alert
    @label = label
  end

  private
  attr_reader :relation, :alert, :label, :filter

  def render?
    relation.any?
  end

end
