module ActiveAdmin
  module Views
    # Build a Blank Slate
    class BlankSlate < ActiveAdmin::Component
      builder_method :blank_slate

      def default_class_name
        'blank_slate_container'
      end

      def build(content)
        blank_slate_icon    = i("inbox", class: "cb_activeadmin-icons")
        blank_slate_heading = h4(I18n.t("active_admin.blank_slate.heading"), class: "title")
        blank_slate_content = span(content.html_safe, class: "blank_slate")
        super([blank_slate_icon, blank_slate_heading, blank_slate_content].compact.join(" ").html_safe)
      end

    end
  end
end
