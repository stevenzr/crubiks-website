module Plugins::MyPlugin::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def my_plugin_admin_before_load
  # add menus
  sub_items1 = [
      {icon: "list", title: 'List of my items', url: admin_plugins_my_plugin_index_path},
      {icon: "plus", title: 'New My item', url: '#url_path_to_new_here'}
  ]

  # add menus after certain menu
  admin_menu_insert_menu_after("content", "my_plugin_menu", {icon: 'briefcase', title: 'My Menu Group', url: "", items: sub_items1})
end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def my_plugin_on_active(plugin)
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def my_plugin_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def my_plugin_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def my_plugin_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_my_plugin_settings_path)
  end
end
