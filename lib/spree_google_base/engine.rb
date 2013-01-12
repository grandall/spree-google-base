module SpreeGoogleBase
  class Engine < Rails::Engine
    engine_name 'spree_google_base'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.google_base.environment", :before => :load_config_initializers do |app|
      Spree::GoogleBase::Config = Spree::GoogleBaseConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      if Spree::Config
        Spree::Taxon.has_one :taxon_map
      end
    end

    config.to_prepare &method(:activate).to_proc

  end
end
