class EscalationTimesController < ApplicationController
  before_action :set_escalation_time, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /escalation_times
  def index
    @escalation_times = @escalation_level.escalation_times
    respond_with(@escalation_times)
  end

  # GET /escalation_times/1
  def show
    respond_with(@escalation_time)
  end

  # GET /escalation_times/new
  def new
    @escalation_time = @escalation_level.escalation_times.build
    respond_with(@escalation_time)
  end

  # GET /escalation_times/1/edit
  def edit
  end

  # POST /escalation_times
  def create
    @escalation_time = @escalation_level.escalation_times.build(escalation_time_params)
    respond_with(@escalation_time, location: location) do |format|
      if @escalation_time.save
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /escalation_times/1
  def update
    respond_with(@escalation_time, location: location) do |format|
      if @escalation_time.update(escalation_time_params)
        format.turbo_stream
      end
    end
  end

  # DELETE /escalation_times/1
  def destroy
    respond_with(@escalation_time, location: location) do |format|
      if @escalation_time.destroy
        format.turbo_stream
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escalation_time
      @escalation_time = EscalationTime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def escalation_time_params
      params.require(:escalation_time).permit(
        :escalation_level_id, :start_time, :end_time, weekdays: [],
      )
    end

  def location
    polymorphic_path(@escalation_level)
  end
end
