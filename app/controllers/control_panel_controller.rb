class ControlPanelController < ApplicationController
  before_action :authenticate_user!

  layout "control_panel"

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
  end

  def index
    @services = Service.where(owner_id: current_user.id)
  end
end
