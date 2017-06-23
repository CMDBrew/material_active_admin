module ActiveAdmin

  module Views

    # Extend ActiveAdmin ActionItems - activeadmin/lib/active_admin/views/action_items.rb
    class ActionItems < ActiveAdmin::Component

      private

      def destroy_action?
        controller.action_methods.include?('destroy') &&
          authorized?(ActiveAdmin::Auth::DESTROY, resource)
      end

      def destroy_confirm
        I18n.t('active_admin.delete_confirmation')
      end

      def destroy_btn_title
        I18n.t('active_admin.delete_model', model: active_admin_config.resource_label).to_s
      end

      def new_action?
        controller.action_methods.include?('new') &&
          authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
      end

      def edit_action?
        controller.action_methods.include?('edit') &&
          authorized?(ActiveAdmin::Auth::UPDATE, resource)
      end

      def new_btn_title
        I18n.t('active_admin.new_model', model: active_admin_config.resource_label).to_s
      end

      def edit_btn_title
        I18n.t('active_admin.edit_model', model: active_admin_config.resource_label).to_s
      end

    end

  end

end
