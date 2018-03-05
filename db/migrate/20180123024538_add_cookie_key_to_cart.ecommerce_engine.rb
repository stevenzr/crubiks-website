# This migration comes from ecommerce_engine (originally 20161202182552)
class AddCookieKeyToCart < CamaManager.migration_class
  def change
    add_column :plugins_ecommerce_orders, :visitor_key, :string
  end
end
