module Plugins::Blog::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model

  def cama_blog_post_type
    @_cache_blog_post_type ||= current_site.post_types.where(slug: 'blog').first.try(:decorate)
  end

  def blog_on_active(plugin)
    generate_custom_blog
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def blog_on_inactive(plugin)
    current_site.post_types.hidden_menu.where(slug: 'blog').first.destroy
  end

  def blog_on_destroy(plugin)
    
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def blog_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def blog_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_blog_settings_path)
  end

  # return blog posttype
  def blog_admin_before_load
    # add sub menus
    pt = current_site.post_types.hidden_menu.where(slug: 'blog').first

    if pt.present?
      items_i = []
      items_i << {icon: "list", title: 'All Blog posts', url: cama_admin_post_type_posts_path(pt.id)} if can? :posts, pt
      items_i << {icon: "plus", title: 'Add New post', url: new_cama_admin_post_type_post_path(pt.id)} if can? :create_post, pt

      if pt.manage_categories?
        items_i << {icon: "folder-open", title: 'Categories', url: cama_admin_post_type_categories_path(pt.id)} if can? :categories, pt
      end

      if pt.manage_tags?
        items_i << {icon: "tags", title: 'Tags', url: cama_admin_post_type_post_tags_path(pt.id)} if can? :post_tags, pt
      end
      #add main menu in the admin panel
      admin_menu_insert_menu_after("content", "blog_menu", {icon: 'newspaper-o', title: 'Blog', url: "", items: items_i})
    end
  end

  private
  def generate_custom_blog
    blog = current_site.post_types.hidden_menu.where(slug: "blog").first #need new slug for call "post" from main folder
    unless blog.present?
      blog = current_site.post_types.hidden_menu.new(slug: "blog", name: "blog")
      if blog.save
        blog.set_options({ #this will add content groups to cms
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
        blog.categories.create({name: 'Uncategorized', slug: 'Uncategorized'.parameterize});

      end

    end
    unless blog.get_field_groups.where(slug: "plugin_blog").present?
      blog.get_field_groups.destroy_all
      group = blog.add_custom_field_group({name: 'Blog Post', slug: 'plugin_blog'})
    end
  end

    #-------------------------------------------------------------------#

    # sub_items_i = []

    # sub_items_i << {icon: "list", title: 'All Items', url: cama_admin_post_type_posts_path(:id)}
    # sub_items_i << {icon: "plus", title: 'Add New', url: '#url_path_to_new_here'}
    # #sub_items_i << {icon: "folder-open", title: t('camaleon_cms.admin.post_type.categories', default: 'Categories'), url: cama_admin_post_type_categories_path(pt.id)} if can? :categories, pt
    # sub_items_i << {icon: "folder-open", title: 'Categories', url: cama_admin_post_type_categories_path(:id)}
    # sub_items_i << {icon: "tags", title: 'Tags', url: '#url_path_to_new_here'}

    # #add menus after certain menu
    # admin_menu_insert_menu_after("content", "blog_menu", {icon: 'newspaper-o', title: 'Blog', url: "", items: sub_items_i}) if sub_items_i.present?

end

