# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]
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
    Rails.logger.debug {"notable: #{@notable}"}
    @note = @notable.notes.build(type: params[:type] || 'note')
    respond_with(@note)
  end

  # GET /notes/1/edit
  def edit; end

  # POST /notes
  def create
    @note = @notable.notes.build(default_note_params.merge(note_params, force_note_params))
    respond_with(@note, location: location) do |format|
      if @note.save
        format.turbo_stream
        add_current_note
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  def update
    respond_with(@note, location: location) do |format|
      if @note.update(note_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end 
  end

  # DELETE /notes/1
  def destroy
    respond_with(@note, location: location) do |format|
      if @note.destroy
        format.turbo_stream
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params.require(:note).permit(:channel_id, :server_id, :channel_statistic_id, 
                                 :notable_id, :notable_type, :message, :type,
                                 :valid_until)
  end

  def default_note_params
    {
      type: 'note'
    }
  end

  def force_note_params
    {
      user_id: @current_user.id
    }
  end

  def location
    # polymorphic_path([@notable, :notes])
    polymorphic_path(@notable, anchor: 'notes')
  end

  def add_current_note
    return unless @notable.respond_to?(:current_note_id)
    @notable.update(current_note_id: @note.id)
  end
end
