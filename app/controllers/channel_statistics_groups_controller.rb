class ChannelStatisticsGroupsController < ApplicationController
  before_action :set_channel_statistics_group, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistics_groups
  def index
    @channel_statistics_groups = ChannelStatisticsGroup.all
    respond_with(@channel_statistics_groups)
  end

  # GET /channel_statistics_groups/1
  def show
    respond_with(@channel_statistics_group)
  end

  # GET /channel_statistics_groups/new
  def new
    @channel_statistics_group = ChannelStatisticsGroup.new
    respond_with(@channel_statistics_group)
  end

  # GET /channel_statistics_groups/1/edit
  def edit
  end

  # POST /channel_statistics_groups
  def create
    @channel_statistics_group = ChannelStatisticsGroup.new(channel_statistics_group_params)

    @channel_statistics_group.save
    respond_with(@channel_statistics_group)
  end

  # PATCH/PUT /channel_statistics_groups/1
  def update
    @channel_statistics_group.update(channel_statistics_group_params)
    respond_with(@channel_statistics_group)
  end

  # DELETE /channel_statistics_groups/1
  def destroy
    @channel_statistics_group.destroy
    respond_with(@channel_statistics_group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_statistics_group
      @channel_statistics_group = ChannelStatisticsGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_statistics_group_params
      params.require(:channel_statistics_group).permit(:name)
    end
end
