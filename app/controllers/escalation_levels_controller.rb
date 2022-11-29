class EscalationLevelsController < ApplicationController
  before_action :set_escalation_level, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /escalation_levels
  def index
    @escalation_levels = EscalationLevel.all
    respond_with(@escalation_levels)
  end

  # GET /escalation_levels/1
  def show
    respond_with(@escalation_level)
  end

  # GET /escalation_levels/new
  def new
    @escalation_level = EscalationLevel.new
    respond_with(@escalation_level)
  end

  # GET /escalation_levels/1/edit
  def edit
  end

  # POST /escalation_levels
  def create
    @escalation_level = EscalationLevel.new(escalation_level_params)

    @escalation_level.save
    respond_with(@escalation_level)
  end

  # PATCH/PUT /escalation_levels/1
  def update
    @escalation_level.update(escalation_level_params)
    respond_with(@escalation_level)
  end

  # DELETE /escalation_levels/1
  def destroy
    @escalation_level.destroy
    respond_with(@escalation_level)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escalation_level
      @escalation_level = EscalationLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def escalation_level_params
      params.require(:escalation_level).permit(:escalatable_id, :escalatable_type, :attrib, :min_critical, :min_warning, :max_warning, :max_critical)
    end
end
