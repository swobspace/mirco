class SoftwareController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software
  def index
    @software = Software.all
    respond_with(@software)
  end

  # GET /software/1
  def show
    respond_with(@software)
  end

  # GET /software/new
  def new
    @software = Software.new
    respond_with(@software)
  end

  # GET /software/1/edit
  def edit
  end

  # POST /software
  def create
    @software = Software.new(software_params)

    @software.save
    respond_with(@software)
  end

  # PATCH/PUT /software/1
  def update
    @software.update(software_params)
    respond_with(@software)
  end

  # DELETE /software/1
  def destroy
    @software.destroy
    respond_with(@software)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_params
      params.require(:software).permit(:location_id, :name)
    end
end
