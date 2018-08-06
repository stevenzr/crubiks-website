class Plugins::SampleMenu::Admin::JobDivisionsController < Plugins::SampleMenu::AdminController
  before_action :set_order, only: ['show','edit','update','destroy']

  def index
    render 'index'
  end

end