Product.class_eval do
  scope :google_base_scope, includes(:variants, :taxons, :images)
  
  protected

  def google_base_id(variant)
    variant.sku
  end
  
  def google_base_title(variant)
    self.name
  end
  
  def google_base_description(variant)
    self.description
  end
  
  def google_base_condition(variant)
    'new'
  end

  def google_base_availability(variant)
    'in stock'
  end

  def google_base_price(variant)
    variant.price
  end

  def google_base_link(variant)
    public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    [public_dir.sub(/\/$/, ''), 'products', self.permalink].join('/')
  end
  
  def google_base_image_link(variant)
    public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    if self.images.empty?
      nil
    else
      public_dir.sub(/\/$/, '') + self.images.first.attachment.url(:product)
    end
  end

  def google_base_product_type(variant)
    return nil unless Spree::GoogleBase::Config[:enable_taxon_mapping]
    product_type = ''
    priority = -1000
    self.taxons.each do |taxon|
      if taxon.taxon_map && taxon.taxon_map.priority > priority
        priority = taxon.taxon_map.priority
        product_type = taxon.taxon_map.product_type
      end
    end
    product_type
  end
end
