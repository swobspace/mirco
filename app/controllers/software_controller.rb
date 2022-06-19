class SoftwareController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software
  def index
    if @softwareable
      @software = @softwareable.software
    else
      @software = Software.all
    end
    respond_with(@software)
  end

  # GET /software/1
  def show
    respond_with(@software)
  end

  # GET /software/new
  def new
    if @softwareable
      @software = @softwareable.software.build
    else
      @software = Software.new
    end
    respond_with(@software)
  end

  # GET /software/1/edit
  def edit
  end

  # POST /software
  def create
    if @softwareable
      @software = @softwareable.software.build(software_params)
    else
      @software = Software.new(software_params)
    end

    @software.save
    respond_with(@software, location: location)
  end

  # PATCH/PUT /software/1
  def update
    @software.update(software_params)
    respond_with(@software, location: location)
  end

  # DELETE /software/1
  def destroy
    @software.destroy
    respond_with(@software, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_params
      params.require(:software).permit(:location_id, :name, :description, :vendor,
                                       :software_group_id)
    end

    def location
      polymorphic_path(@software || :software)
    end
end
