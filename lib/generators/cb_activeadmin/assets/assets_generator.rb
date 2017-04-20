module CbActiveadmin
  module Generators
    class AssetsGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      def replace_assets
        gsub_file "app/assets/javascripts/active_admin.js.coffee", "active_admin/", "cb_activeadmin/"
        gsub_file "app/assets/stylesheets/active_admin.scss", "active_admin/", "cb_activeadmin/"
      end

    end
  end
end
