module ActiveAdmin

  module Views

    # Overwriting TitleBar Component - activeadmin/lib/active_admin/views/title_bar.rb
    # rubocop:disable Metrics/ClassLength
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

      def build_sidebar_toggle
        div id: 'sidebar-toggle', class: 'nav-icon'
      end

      def build_search_toggle
        div class: 'button-wrap' do
          div id: 'search-filter-toggle', class: 'nav-icon', title: search_toggle_title,
              'data-toggle' => 'tooltip', 'data-placement' => 'bottom'
        end
      end

      def search_toggle_title
        I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
      end

      def build_search_filters
        div id: 'search-filter' do
          div class: 'header' do
            span I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
            div i('close', class: 'cb_activeadmin-icons'), class: 'search-close'
          end
          div @filters.collect { |x| sidebar_section(x) }, class: 'body'
        end
      end

      def build_batch_actions_selector
        return unless active_admin_config.batch_actions.any?
        insert_tag view_factory.batch_action_selector, active_admin_config.batch_actions
      end

      def build_titlebar_left
        div id: 'titlebar_left' do
          build_sidebar_toggle
          build_breadcrumb('')
          build_title_tag
        end
      end

      def build_titlebar_right
        div id: 'titlebar_right' do
          if @is_index_page
            build_batch_actions_selector
            build_index_list
            build_search_toggle
            build_search_filters
          end
          build_action_items
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

    end

  end

end
