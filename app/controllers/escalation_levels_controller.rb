class EscalationLevelsController < ApplicationController
  before_action :set_escalation_level, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /escalation_levels
  def index
    if @escalatable
      case @escalatable.class.name
      when "ChannelStatistic"
        @escalation_levels = @escalatable.all_escalation_levels
      else
        @escalation_levels = @escalatable.escalation_levels
      end
    else
      @escalation_levels = EscalationLevel.all
    end
    respond_with(@escalation_levels)
  end

  # GET /escalation_levels/1
  def show
    respond_with(@escalation_level)
  end

  # GET /escalation_levels/new
  def new
    @escalation_level = @escalatable.escalation_levels.build
    respond_with(@escalation_level)
  end

  # GET /escalation_levels/1/edit
  def edit
  end

  # POST /escalation_levels
  def create
    @escalation_level = @escalatable.escalation_levels.build(escalation_level_params)

    @escalation_level.save
    respond_with(@escalation_level, location: location)
  end

  # PATCH/PUT /escalation_levels/1
  def update
    @escalation_level.update(escalation_level_params)
    respond_with(@escalation_level, location: location)
  end

  # DELETE /escalation_levels/1
  def destroy
    @escalation_level.destroy
    respond_with(@escalation_level, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escalation_level
      @escalation_level = EscalationLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def escalation_level_params
      params.require(:escalation_level).permit(
        :escalatable_id, :escalatable_type, :attrib,
        :min_critical, :min_warning, :max_warning, :max_critical,
        :show_on_dashboard, :notification_group_id,
        escalation_times_attributes: [
          :id, :start_time, :end_time, :_destroy, weekdays: []
        ]
      )
    end

    def location
      if action_name == 'destroy'
        polymorphic_path(@escalatable || :escalation_levels)
      else
        polymorphic_path([@escalatable, @escalation_level])
      end
    end
end
