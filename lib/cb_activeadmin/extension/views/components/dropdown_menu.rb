module ActiveAdmin

  module Views

    # Overwriting DropdownMenu - activeadmin/lib/active_admin/views/components/dropdown_menu.rb
    class DropdownMenu < ActiveAdmin::Component

      def divider(extra_klass = nil)
        within @menu do
          li '', class: "divider #{extra_klass}"
        end
      end

    end

  end

end
