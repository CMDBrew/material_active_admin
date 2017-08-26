module ActiveAdmin

  module Views

    # Register ActiveAdmin Extension FloatAction
    class FloatActions < ActiveAdmin::Component

      def build(float_actions)
        @float_actions = float_actions
        float_actions.length > 1 ? build_bottom_sheet : build_actions
      end

      private

      def float_item(title, icon, url, html_options = {})
        html_options[:class] = "float-item #{html_options[:class]}"
        link_to url, html_options do
          content_tag(:i, '', class: "mdi-aa-icon-#{icon}") <<
            content_tag(:span, title)
        end
      end

      def build_bottom_sheet
        @float_actions.each do |float_action|
          div class: 'float_action' do
            instance_exec(&float_action.block)
          end
        end
      end

      def build_actions
        @float_actions.each do |float_action|
          div class: 'float_action' do
            instance_exec(&float_action.block)
          end
        end
      end

    end

  end

end
