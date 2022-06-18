class SoftwareGroupsController < ApplicationController
  before_action :set_software_group, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software_groups
  def index
    @software_groups = SoftwareGroup.all
    respond_with(@software_groups)
  end

  # GET /software_groups/1
  def show
    respond_with(@software_group)
  end

  # GET /software_groups/new
  def new
    @software_group = SoftwareGroup.new
    respond_with(@software_group)
  end

  # GET /software_groups/1/edit
  def edit
  end

  # POST /software_groups
  def create
    @software_group = SoftwareGroup.new(software_group_params)

    @software_group.save
    respond_with(@software_group)
  end

  # PATCH/PUT /software_groups/1
  def update
    @software_group.update(software_group_params)
    respond_with(@software_group)
  end

  # DELETE /software_groups/1
  def destroy
    @software_group.destroy
    respond_with(@software_group)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_group
      @software_group = SoftwareGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_group_params
      params.require(:software_group).permit(:name, :description)
    end
end
