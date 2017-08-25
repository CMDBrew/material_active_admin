module ActiveAdmin

  class Resource

    # Overwriting ActionItems - activeadmin/lib/active_admin/resource/action_items.rb
    module ActionItems

      private

      # Adds the default action items to each resource
      def add_default_action_items
        add_default_show_action_item
      end

      # Adds the default Destroy link on show
      def add_default_show_action_item
        add_action_item :destroy, only: :show do
          if destroy_action?
            link_to(
              content_tag(:i, '', class: 'mdi-aa-icon-delete'),
              resource_path(resource),
              class: 'nav-icon', method: :delete, title: destroy_btn_title,
              data: { confirm: destroy_confirm, toggle: 'tooltip', placement: 'bottom' }
            )
          end
        end
      end

    end

  end

end
