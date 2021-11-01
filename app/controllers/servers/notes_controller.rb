class Servers::NotesController < NotesController
  before_action :set_notable

private

  def set_notable
    @notable = Server.find(params[:server_id])
  end

  def location
    server_path(@notable)
  end
end

