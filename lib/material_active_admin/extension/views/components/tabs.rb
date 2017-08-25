module ActiveAdmin

  module Views

    # Register Tabs in Views
    class Tabs < ActiveAdmin::Component

      builder_method :tabs

      def tab(title, options = {}, &block)
        title = title.to_s.titleize if title.is_a? Symbol
        @menu << build_menu_item(title, options, &block)
        @tabs_content << build_content_item(title, options, &block)
      end

      def build(type = 'jquery')
        add_class 'disable-jquery-ui-tabs' unless type == 'jquery'
        div class: 'nav-tabs-wrap' do
          @menu = ul(class: 'nav nav-tabs', role: 'tablist')
        end
        @tabs_content = div(class: 'tab-content')
      end

      def build_menu_item(title, options)
        options = options.reverse_merge({})
        li options do
          link_to title, "##{title.parameterize}", options
        end
      end

      def build_content_item(title, options, &block)
        options = options.reverse_merge(id: title.parameterize)
        div(options, &block)
      end

    end

  end

end
