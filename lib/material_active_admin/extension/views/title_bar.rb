module ActiveAdmin

  module Views

    # Overwriting TitleBar Component - activeadmin/lib/active_admin/views/title_bar.rb
    class TitleBar < Component

      # rubocop:disable Style/OptionHash
      def build(title, action_items, is_index_page = false, options = {})
        super(id: 'title_bar')
        @title         = title
        @action_items  = action_items
        @is_index_page = is_index_page
        @filters       = options[:filters]
        build_titlebar_left
        build_titlebar_right
      end

      private

      def build_title_tag
        h3(@title, id: 'page_title')
      end

      def build_sidebar_toggle
        div id: 'sidebar-toggle' do
          a class: 'nav-icon sidebar-toggle' do
            i '', class: 'aa-icon-menu'
          end
        end
      end

      def build_search_toggle
        title = I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
        div id: 'search-filter-toggle',
            class: 'nav-icon filter-toggle',
            'data-toggle' => 'tooltip',
            'data-placement' => 'bottom',
            'data-original-title' => title do
          i '', class: 'aa-icon-magnify'
        end
      end

      def search_toggle_title
        I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
      end

      def build_search_filters
        div id: 'search-filter' do
          div class: 'header' do
            span I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
            div i('', class: 'aa-icon-close'), class: 'search-close filter-toggle'
          end
          div @filters.collect { |x| sidebar_section(x) }, class: 'body'
        end
      end

      def build_site_title
        insert_tag view_factory.site_title, active_admin_namespace
      end

      def build_titlebar_left
        div id: 'titlebar_left', class: 'titlebar-section' do
          build_sidebar_toggle
          # build_site_title
          build_breadcrumb
          build_title_tag
        end
      end

      def build_titlebar_right
        div id: 'titlebar_right', class: 'titlebar-section' do
          build_index_list if @is_index_page
          build_action_items
          if @is_index_page
            build_search_toggle
            build_search_filters
          end
        end
      end

      def build_index_list(current_index: nil, index_classes: [])
        return unless build_index_list?
        active_admin_config.page_presenters[:index].each do |_type, page_presenter|
          index_renderer_class = find_index_renderer_class(page_presenter[:as])
          index_classes << index_renderer_class
          next unless current_index? index_renderer_class
          current_index = index_renderer_class
        end
        display_selector(index_classes, current_index.index_name)
      end

      def build_index_list?
        indexes.is_a?(Hash) && indexes.length > 1
      end

      def indexes
        active_admin_config.page_presenters[:index]
      end

      def display_selector(index_classes, name)
        div class: 'display_selector dropdown_menu' do
          a display_selector_title(name),
            class: 'dropdown_menu_button nav-icon', 'data-toggle' => 'tooltip',
            'data-placement' => 'bottom', 'title' => I18n.t('active_admin.display_as').to_s
          div index_list_renderer(index_classes), class: 'dropdown_menu_list_wrapper'
        end
      end

      def display_selector_title(name)
        # rubocop:disable Rails/OutputSafety
        I18n.t("active_admin.index_list.#{name}", default: name.to_s.titleize).html_safe
      end

      def current_index?(index_class)
        if params[:as]
          params[:as] == index_class.index_name
        else
          active_admin_config.default_index_class == index_class
        end
      end

      def find_index_renderer_class(klass)
        if klass.is_a?(Class)
          klass
        else
          ::ActiveAdmin::Views.const_get('IndexAs' + klass.to_s.camelcase)
        end
      end

      def any_table_tools?
        active_admin_config.batch_actions.any? || active_admin_config.scopes.any? ||
          active_admin_config.page_presenters[:index].try(:size).try(:>, 1)
      rescue
        false
      end

      def build_breadcrumb(separator = '/')
        links = build_breadcrumb_links
        return unless links.present? && links.is_a?(::Array)
        span class: 'breadcrumb' do
          links.each do |link|
            text_node link
            span(separator, class: 'breadcrumb_sep')
          end
        end
      end

      def build_breadcrumb_links
        breadcrumb_config = active_admin_config && active_admin_config.breadcrumb
        if breadcrumb_config.is_a?(Proc)
          instance_exec(controller, &active_admin_config.breadcrumb)
        elsif breadcrumb_config.present?
          breadcrumb_links
        end
      end

    end

  end

end
