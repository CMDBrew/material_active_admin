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

  end

end
