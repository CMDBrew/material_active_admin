module Formtastic

  module Inputs

    # Overwriting BooleanInput from Formtastic - formtastic/lib/formtastic/inputs/boolean_input.rb
    class BooleanInput

      def label_text_with_embedded_checkbox
        check_box_html << '' << label_icon << '' << label_text
      end

      def label_icon
        template.content_tag :span, '', class: 'checkbox-icon'
      end

      def label_text
        template.content_tag :span, class: 'checkbox-label' do
          (localized_label || humanized_method_name) +
            requirement_text
        end
      end

    end

  end

end
