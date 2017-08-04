module ActiveAdmin

  module BatchActions

    # Overwriting activeadmin/lib/active_admin/batch_actions/resource_extension.rb
    module ResourceExtension

      private

      # @return [ActiveAdmin::BatchAction] The default "delete" action
      # rubocop:disable Metric/AbcSize, Metric/MethodLength
      def add_default_batch_action
        add_batch_action :destroy,
                         proc { I18n.t('active_admin.delete') }, destroy_options do |selected_ids|
          batch_action_collection.find(selected_ids).each do |record|
            authorize! ActiveAdmin::Auth::DESTROY, record
            destroy_resource(record)
          end

          notice = I18n.t(
            'active_admin.batch_actions.succesfully_destroyed',
            count: selected_ids.count,
            model: active_admin_config.resource_label.downcase,
            plural_model: active_admin_config.
              plural_resource_label(count: selected_ids.count).downcase
          )
          redirect_to active_admin_config.route_collection_path(params),
                      notice: notice
        end
      end

      def destroy_options
        {
          icon: 'delete',
          priority: 100,
          confirm: proc {
            I18n.t('active_admin.batch_actions.delete_confirmation',
                   plural_model: active_admin_config.plural_resource_label.downcase)
          },
          if: proc {
            controller.action_methods.include?('destroy') &&
              authorized?(ActiveAdmin::Auth::DESTROY, active_admin_config.resource_class)
          }
        }
      end

    end

  end

  # Batch Action Override
  class BatchAction

    def initialize(sym, title, options = {}, &block)
      @sym           = sym
      @title         = title
      @options       = options
      @block         = block
      @confirm       = options[:confirm]
      @icon          = options[:icon]
      @hidden_mobile = options[:hidden_mobile]
      @dropdown_item = options[:dropdown_item]
      @block ||= proc {}
    end

    def icon
      @options[:icon]
    end

    def hidden_mobile
      @options[:hidden_mobile] || false
    end

    def dropdown_item
      @options[:dropdown_item] || false
    end

  end

end
