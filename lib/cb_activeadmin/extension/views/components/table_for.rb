module ActiveAdmin
  module Views
    class TableFor < Arbre::HTML::Table
      def resource_selection_toggle_cell
        label class: "mdi-checkbox" do
          input type: "checkbox", id: "collection_selection_toggle_all", name: "collection_selection_toggle_all", class: "toggle_all"
          span class: "checkbox-icon"
        end
      end

      def resource_selection_cell(resource)
        label class: "mdi-checkbox" do
          input type: "checkbox", id: "batch_action_item_#{resource.id}", value: resource.id, class: "collection_selection", name: "collection_selection[]"
          span class: "checkbox-icon"
        end
      end

      def actions(options = {}, &block)
        name          = options.delete(:name)     { '' }
        defaults      = options.delete(:defaults) { true }
        dropdown      = options.delete(:dropdown) { false }
        dropdown_name = options.delete(:dropdown_name) { I18n.t 'active_admin.dropdown_actions.button_label', default: 'Actions' }

        options[:class] ||= 'col-actions'

        column name, options do |resource|
          if dropdown
            dropdown_menu dropdown_name do
              instance_exec(resource, &block) if block_given?
            end
          else
            table_actions do
              if block_given?
                block_result = instance_exec(resource, &block)
                text_node block_result unless block_result.is_a? Arbre::Element
              end
            end
          end
        end
      end

      private

      class TableActions < ActiveAdmin::Component
        builder_method :table_actions

        def item *args
          text_node link_to *args
        end
      end
    end
  end
end
