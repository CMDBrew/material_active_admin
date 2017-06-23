module ActiveAdmin

  class Resource

    # Overwriting ActionItems - activeadmin/lib/active_admin/resource/action_items.rb
    module ActionItems

      private

      # Adds the default action items to each resource
      def add_default_action_items
        add_default_show_action_item
      end

      # Adds the default New link on index
      def add_default_new_action_item
        add_action_item :new, only: :index do
          if new_action?
            link_to(
              content_tag(:i, 'add_circle_outline', class: 'aa-icon'),
              new_resource_path,
              title: new_btn_title,
              data: { toggle: 'tooltip', placement: 'bottom' }
            )
          end
        end
      end

      # Adds the default Edit link on show
      def add_default_edit_action_item
        add_action_item :edit, only: :show do
          if edit_action?
            link_to(
              content_tag(:i, 'mode_edit', class: 'aa-icon'),
              edit_resource_path(resource),
              title: edit_btn_title,
              data: { toggle: 'tooltip', placement: 'bottom' }
            )
          end
        end
      end

      # Adds the default Destroy link on show
      def add_default_show_action_item
        add_action_item :destroy, only: :show do
          if destroy_action?
            link_to(
              content_tag(:i, 'delete', class: 'aa-icon'),
              resource_path(resource),
              method: :delete, title: destroy_btn_title,
              data: { confirm: destroy_confirm, toggle: 'tooltip', placement: 'bottom' }
            )
          end
        end
      end

    end

  end

end
