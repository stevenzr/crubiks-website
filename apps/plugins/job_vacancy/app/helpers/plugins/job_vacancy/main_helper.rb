module Plugins::JobVacancy::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def cama_job_vacancy_post_type
    @_cache_job_vacancy_post_type ||= current_site.post_types.where(slug: 'job').first.try(:decorate)
  end

  def job_vacancy_admin_before_load
  # add menus
    pt = current_site.post_types.hidden_menu.where(slug: "job").first # need this for add / call "post" from master file
    if pt.present?
  items_i = []
  items_i << {icon: "list", title: 'List of jobs', url: cama_admin_post_type_posts_path(pt.id)} if can? :posts, pt
  items_i << {icon: "plus", title: 'Add job', url: new_cama_admin_post_type_post_path(pt.id)} if can? :create_post, pt
  if pt.manage_categories?
    items_i << {icon: "folder-open", title: 'Job Categories/Division', url: cama_admin_post_type_categories_path(pt.id)} if can? :categories, pt
  end
  if pt.manage_tags?
    items_i << {icon: "tags", title: 'Job Tags', url: cama_admin_post_type_post_tags_path(pt.id)} if can? :post_tags, pt
  end

  if can? :posts, pt
    items_i << {icon: "apple", title: 'Job Division', url: admin_plugins_job_vacancy_job_divisions_path}
  end


  # add menus after certain menu
  admin_menu_insert_menu_after("content", "job_vacancy_menu", {icon: 'briefcase', title: 'Job Vacancy', url: "", items: items_i})  if items_i.present?

end
  end

  # here all actions on plugin destroying
  # plugin: plugin model
  def job_on_destroy(plugin)
  end
  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def job_vacancy_on_active(plugin)
    generate_custom_field_job
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def job_vacancy_on_inactive(plugin)
    current_site.post_types.hidden_menu.where(slug: "job").first.destroy

  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def job_vacancy_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def job_vacancy_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_job_vacancy_settings_path)
  end

  private
  def generate_custom_field_job
    job = current_site.post_types.hidden_menu.where(slug: "job").first #need new slug for call "post" from main folder
    unless job.present?
      job = current_site.post_types.hidden_menu.new(slug: "job", name: "job")
      if job.save
        job.set_options({ #this will add content groups to cms
            has_category: true,
            has_tags: true,
            not_deleted: true,
            has_summary: true,
            has_content: true,
            has_comments: true,
            has_picture: true,
            has_template: false,
            has_featured: true

        })
        job.categories.create({name: 'Uncategorized', slug: 'Uncategorized'.parameterize});

      end

    end
    unless job.get_field_groups.where(slug: "plugin_job_vacancy_job_data").present?
      job.get_field_groups.destroy_all
      group = job.add_custom_field_group({name: 'Job Details', slug: 'plugin_job_vacancy_job_data'})
      group.add_manual_field({"name" => "t('plugins.job_vacancy.job.division', default: 'Job Division')", "slug" => "job_vacancy_job", description: "t('plugins.job_vacancy.job.job_dscr', default: 'Please choose one of the job divisions that have been added before')"}, {field_key: "select_eval", required: false, command: "options_from_collection_for_select(current_site.job_divisions.all, \"id\", \"the_name\")", label_eval: true})
      end
  end
end