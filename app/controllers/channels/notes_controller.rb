class Channels::NotesController < NotesController
  before_action :set_notable

private

  def set_notable
    @notable = Channel.find(params[:channel_id])
  end

  def location
    channel_path(@notable)
  end
end

