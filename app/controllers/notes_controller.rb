class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /notes
  def index
    @notes = @notable.notes
    respond_with(@notes)
  end

  # GET /notes/1
  def show
    respond_with(@note)
  end

  # GET /notes/new
  def new
    @note = Note.new
    respond_with(@note)
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    newparams = note_params.merge(fix_note_params)
    Rails.logger.debug("DEBUG:: note params: #{newparams.inspect}")
    @note = @current_user.notes.build(newparams)
    # @note = @current_user.notes.build(note_params.merge(fix_note_params))

    if @note.save
      respond_with(@note, location: location)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      respond_with(@note, location: location)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    respond_with(@note, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_params
      params.require(:note).permit(:channel_id, :server_id, :message, :note)
    end

    def fix_note_params
      { 
        type: 'note',
        channel_id: (@notable.kind_of?(Channel) ? @notable.id : nil),
        server_id:  (@notable.kind_of?(Channel) ? @notable.server.id : @notable.id),
      }
    end

    def add_breadcrumb_show
      add_breadcrumb_for([@notable, @note])
    end

    def location
      polymorphic_path([@notable, :notes])
      # polymorphic_path(@notable, anchor: :notes)
    end
end
