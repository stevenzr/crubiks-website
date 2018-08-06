class Plugins::JobVacancy::Admin::JobDivisionsController < Plugins::JobVacancy::AdminController
  before_action :set_order, only: ['show','edit','update','destroy']

  def index
    @job_divisions = current_site.job_divisions.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
  end

  def new
    @job_division = current_site.job_divisions.new
    add_breadcrumb("#{t('plugins.job_vacancy.new')}")
    render 'form'
  end

  def show
  end

  def edit
    add_breadcrumb("#{t('camaleon_cms.admin.button.edit')}")
    render 'form'
  end

  def create
    @job_division = current_site.job_divisions.new(job_division_permit_data)
    if @job_division.save
      @job_division.set_meta('_default', params[:options])
      flash[:notice] = t('camaleon_cms.admin.post_type.message.created')
      redirect_to action: :index
    else
      render 'form'
    end
  end

  def update
    if @job_division.update(job_division_permit_data)
      @job_division.set_meta('_default', params[:options])
      flash[:notice] = t('camaleon_cms.admin.post_type.message.updated')
      redirect_to action: :index
    else
      render 'form'
    end
  end


  private
  def job_division_permit_data
    params.require(:plugins_job_vacancy_job_division).permit!
  end

  def set_order
    @job_division = current_site.job_divisions.find(params[:id])
  end
end