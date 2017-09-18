module ActiveAdmin

  module Views

    # Register ActiveAdmin Extension FloatAction
    class FloatActions < ActiveAdmin::Component

      def build(float_actions)
        float_actions.each do |float_action|
          div class: 'float_action' do
            instance_exec(&float_action.block)
          end
        end
      end

      private

      def float_btn(icon, url, html_options = {})
        size = html_options.delete(:size) { '' }
        html_options[:class] = "float-btn #{html_options[:class]} #{size}".rstrip
        link_to url, html_options do
          content_tag(:i, '', class: "aa-icon-#{icon}")
        end
      end

    end

  end

end
