class Plugins::Blog::Blog < ActiveRecord::Base
	include CamaleonCms::Metas
  # belongs_to :site, class_name: "CamleonCms::Site"

  # here create your models normally
  # notice: your tables in database will be plugins_blog in plural (check rails documentation)
end