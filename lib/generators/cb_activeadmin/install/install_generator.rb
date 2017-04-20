require 'rails/generators/active_record'

module CbActiveadmin
  class InstallGenerator < Rails::Generators::Base
    desc "Installs CbActiveadmin and generates the necessary migrations & overwrites"
    source_root File.expand_path("../templates", __FILE__)

    def install_active_admin
      generate "active_admin:install"
    end

    def install_configs
      generate "cb_activeadmin:configs"
    end

    def install_assets
      generate "cb_activeadmin:assets"
    end

    def replace_active_admin_defaults
      template 'dashboard.rb.erb', 'app/admin/dashboard.rb'
      template 'admin_user.rb.erb', 'app/admin/admin_user.rb'
    end

  end
end
