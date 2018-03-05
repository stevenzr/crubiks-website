# This migration comes from ecommerce_engine (originally 20161214224919)
class RemoveEcommerceStockField < CamaManager.migration_class
  def change
    Cama::PostType.where(slug: 'commerce').each do |pt|
      pt.get_field_object('ecommerce_stock').try(:destroy)
    end
  end
end
