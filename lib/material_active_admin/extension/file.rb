module Formtastic

  module Inputs

    # Overwriting Formastic Default FileInput - formtastic/lib/formtastic/inputs/file_input.rb
    class FileInput

      include Base

      def to_html
        input_wrapping do
          label_html << file_input
        end
      end

      def file_input
        template.content_tag(:div, class: 'file-container') do
          file_placeholder + file_button
        end
      end

      private

      def file_placeholder
        template.content_tag(
          :div, ::I18n.t('active_admin.placeholders.choose_file'), class: 'file-text'
        )
      end

      def file_button
        template.content_tag(
          :label, label_text, class: 'file-input aa-btn-solid brand-primary btn-sm'
        ) do
          template.content_tag(:span, ::I18n.t('active_admin.choose_file')) <<
            builder.file_field(method, input_html_options)
        end
      end

    end

  end

end
