module CbActiveadmin
  module Generators
    class ConfigsGenerator < Rails::Generators::Base

      def add_meta_tags
        inject_into_file 'config/initializers/active_admin.rb', after: "#   config.meta_tags = { author: 'My Company' }\n" do<<-'RUBY'
  config.meta_tags = { viewport: 'width=device-width, height=device-height, initial-scale=1.0, user-scalable=no' }
        RUBY
        end
      end

      def hide_current_filters
        inject_into_file 'config/initializers/active_admin.rb', after: "# == Filters\n" do<<-'RUBY'
  config.current_filters = false
        RUBY
        end
      end

      def add_menus
        inject_into_file 'config/initializers/active_admin.rb', after: "# == Menu System\n" do<<-'RUBY'
  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add :label    => proc { menu_label("lock", "Admin") },
               :id       => "admin",
               :priority => 999
    end
    
    admin.build_menu :utility_navigation do |menu|
      menu.add  :label    => proc { menu_label("settings", admin_identifier(current_active_admin_user)) },
                :id       => 'current_admin_user',
                :priority => 2

      menu.add  :label    => proc { menu_label("person", "Profile") },
                :id       => "profile",
                :url      => proc { admin_admin_user_path(current_active_admin_user) },
                :priority => 1,
                :parent   => 'current_admin_user'

      menu.add  :label    => proc { menu_label("exit_to_app", "Log Out") },
                :id       => "logout",
                :url      => proc{ destroy_admin_user_session_path },
                :priority => 2,
                :parent   => 'current_admin_user'
    end
  end
        RUBY
        end
      end

      def hide_comments
        gsub_file "config/initializers/active_admin.rb", "# config.comments_menu = false", "config.comments_menu = false"
      end

    end
  end
end
