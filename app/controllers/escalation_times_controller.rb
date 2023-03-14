class EscalationTimesController < ApplicationController
  before_action :set_escalation_time, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /escalation_times
  def index
    @escalation_times = EscalationTime.all
    respond_with(@escalation_times)
  end

  # GET /escalation_times/1
  def show
    respond_with(@escalation_time)
  end

  # GET /escalation_times/new
  def new
    @escalation_time = EscalationTime.new
    respond_with(@escalation_time)
  end

  # GET /escalation_times/1/edit
  def edit
  end

  # POST /escalation_times
  def create
    @escalation_time = EscalationTime.new(escalation_time_params)

    @escalation_time.save
    respond_with(@escalation_time)
  end

  # PATCH/PUT /escalation_times/1
  def update
    @escalation_time.update(escalation_time_params)
    respond_with(@escalation_time)
  end

  # DELETE /escalation_times/1
  def destroy
    @escalation_time.destroy
    respond_with(@escalation_time)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escalation_time
      @escalation_time = EscalationTime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def escalation_time_params
      params.require(:escalation_time).permit(:escalation_level_id, :start_time, :end_time, :weekdays)
    end
end
