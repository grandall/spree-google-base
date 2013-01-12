module Spree
  class GoogleBaseConfiguration < Spree::Preferences::Configuration
    preference :title, :string, :default => 'My Site'
    preference :description, :text, :default => 'My Description'
    preference :ftp_username, :string, :default => ''
    preference :ftp_password, :password, :default => ''
    preference :enable_taxon_mapping, :boolean, :default => false

    preference :public_domain, :string, :default => 'http://www.mysite.com/'
  end
end
