module Formtastic
  module Inputs
    class FileInput
      include Base
      def to_html
        input_wrapping do
          label_html << file_input
        end
      end

      def file_input
        template.content_tag(:div, class: "file-container") do
          html = []
          html << template.content_tag(:span, ::I18n.t("active_admin.placeholders.choose_file"), class: "file-text")
          html << template.content_tag(:label, label_text, class: "file-input mdi-btn brand-primary btn-densed") do
            template.content_tag(:span, ::I18n.t("active_admin.choose_file")) << builder.file_field(method, input_html_options)
          end
          html.join.html_safe
        end
      end
    end
  end
end
