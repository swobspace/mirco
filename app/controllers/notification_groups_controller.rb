class NotificationGroupsController < ApplicationController
  before_action :set_notification_group, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /notification_groups
  def index
    @notification_groups = NotificationGroup.all
    respond_with(@notification_groups)
  end

  # GET /notification_groups/1
  def show
    respond_with(@notification_group)
  end

  # GET /notification_groups/new
  def new
    @notification_group = NotificationGroup.new
    respond_with(@notification_group)
  end

  # GET /notification_groups/1/edit
  def edit
  end

  # POST /notification_groups
  def create
    @notification_group = NotificationGroup.new(notification_group_params)

    @notification_group.save
    respond_with(@notification_group)
  end

  # PATCH/PUT /notification_groups/1
  def update
    @notification_group.update(notification_group_params)
    respond_with(@notification_group)
  end

  # DELETE /notification_groups/1
  def destroy
    @notification_group.destroy
    respond_with(@notification_group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_group
      @notification_group = NotificationGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_group_params
      params.require(:notification_group).permit(:name)
    end
end
