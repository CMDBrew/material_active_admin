module ActiveAdmin

  module Views

    # Register BlankSlate in Views
    class BlankSlate < ActiveAdmin::Component

      builder_method :blank_slate

      def default_class_name
        'blank_slate_container'
      end

      def build(content)
        super(safe_join([
          blank_slate_icon,
          blank_slate_heading,
          blank_slate_content(content)
        ].compact))
      end

      private

      def blank_slate_icon
        i('', class: 'aa-icon-empty')
      end

      def blank_slate_heading
        h3(I18n.t('material_active_admin.blank_slate.heading'), class: 'title')
      end

      def blank_slate_content(content)
        # rubocop:disable Rails/OutputSafety
        content_tag(:span, content.html_safe, class: 'blank_slate')
      end

    end

  end

end
