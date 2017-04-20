module ActiveAdmin
  module Views
    class Header < Component

      def build(namespace, menu)
        super(id: "header")

        @namespace    = namespace
        @menu         = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        build_site_title
        build_global_navigation
        build_utility_navigation
      end


      private

      def build_menu_toggle
        div id: "menu_toggle" do
          i class: "cb_activeadmin-icons" do
            "menu"
          end
        end
        div id: "header_overlay"
      end

    end
  end
end
