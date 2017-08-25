module ActiveAdmin

  module Views

    # Overwriting Header Component - activeadmin/lib/active_admin/views/header.rb
    class Header < Component

      def build(namespace, menu)
        super(id: 'header')

        @namespace    = namespace
        @menu         = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        build_sidebar_toggle
        build_site_title
        div id: 'main-nav' do
          build_global_navigation
          build_utility_navigation
        end
        build_footer
      end

      private

      def build_sidebar_toggle
        div id: 'sidebar-close' do
          i '', class: 'mdi-aa-icon-close'
        end
      end

      def build_footer
        insert_tag view_factory.footer, active_admin_namespace
      end

    end

  end

end
