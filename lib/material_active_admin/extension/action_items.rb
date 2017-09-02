module ActiveAdmin

  class Resource

    # Overwriting ActionItems - activeadmin/lib/active_admin/resource/action_items.rb
    module ActionItems

      def action_items_for(action, render_context = nil)
        action_items.select { |item| item.display_on? action, render_context }.
          sort_by(&:priority)
      end

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
              content_tag(:i, '', class: 'aa-icon-delete'),
              resource_path(resource),
              class: 'nav-icon', method: :delete, title: destroy_btn_title,
              data: { confirm: destroy_confirm, toggle: 'tooltip', placement: 'bottom' }
            )
          end
        end
      end

    end

  end

  # Overwrite ActionItem
  class ActionItem

    attr_accessor :block, :name, :options

    def priority
      options[:priority] || 999
    end

  end

end
