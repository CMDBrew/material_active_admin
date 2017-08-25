require 'rails/generators/active_record'

module MaterialActiveAdmin

  # Install Gem
  class InstallGenerator < Rails::Generators::Base

    desc 'Installs MaterialActiveAdmin and generates the necessary migrations & overwrites'
    source_root File.expand_path('../templates', __FILE__)

    def install_configs
      generate 'material_active_admin:configs'
    end

    def install_assets
      generate 'material_active_admin:assets'
    end

    # def replace_active_admin_defaults
    #   template 'dashboard.rb.erb', 'app/admin/dashboard.rb'
    #   template 'admin_user.rb.erb', 'app/admin/admin_user.rb'
    # end

  end

end
