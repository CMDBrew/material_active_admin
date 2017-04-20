module ActiveAdmin
  class Resource
    module ActionItems

      private

      # Adds the default action items to each resource
      def add_default_action_items
        # add_default_new_action_item
        # add_default_edit_action_item
        add_default_show_action_item
      end

      # Adds the default New link on index
      def add_default_new_action_item
        add_action_item :new, only: :index do
          if controller.action_methods.include?('new') && authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
            link_to content_tag(:i, 'add_circle_outline', class: "cb_activeadmin-icons"), new_resource_path, :title => "#{I18n.t('active_admin.new_model', model: active_admin_config.resource_label)}", :data => {toggle:"tooltip", placement:"bottom"}
          end
        end
      end

      # Adds the default Edit link on show
      def add_default_edit_action_item
        add_action_item :edit, only: :show do
          if controller.action_methods.include?('edit') && authorized?(ActiveAdmin::Auth::UPDATE, resource)
            link_to content_tag(:i, 'mode_edit', class: "cb_activeadmin-icons"), edit_resource_path(resource), :title => "#{I18n.t('active_admin.edit_model', model: active_admin_config.resource_label)}", :data => {toggle:"tooltip", placement:"bottom"}
          end
        end
      end

      # Adds the default Destroy link on show
      def add_default_show_action_item
        add_action_item :destroy, only: :show do
          if controller.action_methods.include?('destroy') && authorized?(ActiveAdmin::Auth::DESTROY, resource)
            link_to content_tag(:i, 'delete', class: "cb_activeadmin-icons"), resource_path(resource),
              method: :delete, :title => "#{I18n.t('active_admin.delete_model', model: active_admin_config.resource_label)}", data: {confirm: I18n.t('active_admin.delete_confirmation'), toggle:"tooltip", placement:"bottom"}
          end
        end
      end

    end
  end
end
