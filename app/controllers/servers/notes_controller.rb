class Servers::NotesController < NotesController
  before_action :set_notable

  private

  def set_notable
    @notable = Server.find(params[:server_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([set_notable, @note])
  end
end
