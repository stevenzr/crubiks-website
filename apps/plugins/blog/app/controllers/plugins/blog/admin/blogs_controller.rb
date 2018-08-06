class Plugins::Blog::Admin::BlogsController < Plugins::Blog::AdminController
  before_action :set_order, only: ['show','edit','update','destroy']

  def index
    @blog = current_site.blog.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
  end

  def new
    @blog = current_site.blog.new
    add_breadcrumb("#{t('plugins.blog.new')}")
    # render 'form'
  end

  def show
    add_breadcrumb("#{t('plugins.blog.table.details')}")
  end

  def edit
    add_breadcrumb("#{t('camaleon_cms.admin.button.edit')}")
    # render 'form'
  end

  def create
    @blog = current_site.blog.new(blog_permit_data)
    if @blog.save
      @blog.set_meta('_default',params[:options])
      flash[:notice] = t('camaleon_cms.admin.post_type.message.created')
      redirect_to action: :index
    else
      # render 'form'
    end
  end

  def update
    if @blog.update(blog_permit_data)
      @blog.set_meta('_default',params[:options])
      flash[:notice] = t('camaleon_cms.admin.post_type.message.updated')
      redirect_to action: :index
    else
      # render 'form'
    end
  end


  private
  def set_order
    @blog = current_site.blogs.find(params[:id])
  end

  def blog_permit_data
    params.require(:plugins_blog_blog).permit!
  end

end
