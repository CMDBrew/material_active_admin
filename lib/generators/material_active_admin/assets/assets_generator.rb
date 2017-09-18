module MaterialActiveAdmin

  module Generators

    # Generates CSS && JavaScript Assets
    class AssetsGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def replace_assets
        gsub_file(
          'app/assets/javascripts/active_admin.js.coffee',
          'active_admin/',
          'material_active_admin/'
        )
        gsub_file(
          'app/assets/stylesheets/active_admin.scss',
          'active_admin/',
          'material_active_admin/'
        )
      end

    end

  end

end
