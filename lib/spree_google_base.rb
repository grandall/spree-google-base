require 'spree/core'
#require_relative '../app/overrides/spree_google_base_hooks' #spree says no need to manually require this any more

module SpreeGoogleBase
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      if Spree::Config
        Spree::Taxon.has_one :taxon_map
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
