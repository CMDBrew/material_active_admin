module ActiveAdmin

  module Views

    # Register TableFor in Views
    class TableFor < Arbre::HTML::Table

      def resource_selection_toggle_cell
        label(class: 'mdi-checkbox') do
          input(
            type: 'checkbox',
            id: 'collection_selection_toggle_all',
            name: 'collection_selection_toggle_all',
            class: 'toggle_all'
          )
          span(class: 'checkbox-icon')
        end
      end

      def resource_selection_cell(resource)
        label(class: 'mdi-checkbox') do
          input(
            type: 'checkbox',
            id: "batch_action_item_#{resource.id}",
            value: resource.id,
            class: 'collection_selection',
            name: 'collection_selection[]'
          )
          span(class: 'checkbox-icon')
        end
      end

      def actions(options = {}, &block)
        options.delete(:defaults) { true }
        name          = options.delete(:name)     { '' }
        dropdown      = options.delete(:dropdown) { false }
        dropdown_name = format_dropdown_name(options)
        options[:class] ||= 'col-actions'
        column name, options do |resource|
          render_action(resource, dropdown, dropdown_name, &block)
        end
      end

      private

      def format_dropdown_name(options)
        options.delete(:dropdown_name) do
          I18n.t('active_admin.dropdown_actions.button_label', default: 'Actions')
        end
      end

      def render_action(resource, dropdown, dropdown_name, &block)
        if dropdown
          render_dropdown_actions(resource, dropdown_name, &block)
        else
          render_inline_actions(resource, &block)
        end
      end

      def render_dropdown_actions(resource, dropdown_name, &block)
        dropdown_menu dropdown_name do
          instance_exec(resource, &block) if block_given?
        end
      end

      def render_inline_actions(resource, &block)
        table_actions do
          if block_given?
            block_result = instance_exec(resource, &block)
            text_node block_result unless block_result.is_a? Arbre::Element
          end
        end
      end

      # Register TableActions
      class TableActions < ActiveAdmin::Component

        builder_method :table_actions

        def item(*args)
          text_node link_to(*args)
        end

      end

    end

  end

end
