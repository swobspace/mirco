class ChannelStatisticGroupsController < ApplicationController
  before_action :set_channel_statistic_group, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistic_groups
  def index
    @channel_statistic_groups = ChannelStatisticGroup.all
    respond_with(@channel_statistic_groups)
  end

  # GET /channel_statistic_groups/1
  def show
    respond_with(@channel_statistic_group)
  end

  # GET /channel_statistic_groups/new
  def new
    @channel_statistic_group = ChannelStatisticGroup.new
    respond_with(@channel_statistic_group)
  end

  # GET /channel_statistic_groups/1/edit
  def edit
  end

  # POST /channel_statistic_groups
  def create
    @channel_statistic_group = ChannelStatisticGroup.new(channel_statistic_group_params)

    @channel_statistic_group.save
    respond_with(@channel_statistic_group)
  end

  # PATCH/PUT /channel_statistic_groups/1
  def update
    @channel_statistic_group.update(channel_statistic_group_params)
    respond_with(@channel_statistic_group)
  end

  # DELETE /channel_statistic_groups/1
  def destroy
    @channel_statistic_group.destroy
    respond_with(@channel_statistic_group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_statistic_group
      @channel_statistic_group = ChannelStatisticGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_statistic_group_params
      params.require(:channel_statistic_group).permit(:name)
    end
end
