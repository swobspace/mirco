# frozen_string_literal: true

class AlertsController < ApplicationController
  before_action :set_alert, only: %i[show]
  before_action :add_breadcrumb_show, only: %i[show]

  # GET /alerts
  def index
    @alerts = Alert.all
    respond_with(@alerts)
  end

  # GET /alerts/1
  def show
    respond_with(@alert)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_alert
    @alert = Alert.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def alert_params
    params.require(:alert).permit(:server_id, :channel_id, :type, :message)
  end
end
