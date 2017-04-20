module ActiveAdmin
  module Views
    class TitleBar < Component
      def build(title, action_items, is_index_page=false, options={})
        super(id: "title_bar")
        @title         = title
        @action_items  = action_items
        @is_index_page = is_index_page
        @filters       = options[:filters]
        build_titlebar_left
        build_titlebar_right
      end

      private

      def build_sidebar_toggle
        div "", id: "sidebar-toggle", class: "nav-icon"
      end

      def build_search_toggle
        div class: "button-wrap" do
          div "", :id              => "search-filter-toggle",
                  :class           => "nav-icon",
                  :title           => "#{I18n.t('active_admin.search_model', model: active_admin_config.resource_label)}",
                  "data-toggle"    => "tooltip",
                  "data-placement" => "bottom"
        end
      end

      def build_search_filters
        div id: "search-filter" do
          div class: "header" do
            span "#{I18n.t('active_admin.search_model', model: active_admin_config.resource_label)}"
            div class: "search-close" do
              i "close", class: "cb_activeadmin-icons"
            end
          end
          div class: "body" do
            @filters.collect do |section|
              sidebar_section(section)
            end
          end
        end
      end

      def build_batch_actions_selector
        if active_admin_config.batch_actions.any?
          insert_tag view_factory.batch_action_selector, active_admin_config.batch_actions
        end
      end

      def build_titlebar_left
        div id: "titlebar_left" do
          build_sidebar_toggle
          build_breadcrumb(separator = '')
          build_title_tag
        end
      end

      def build_titlebar_right
        div id: "titlebar_right" do
          if @is_index_page
            build_batch_actions_selector
            build_index_list
            build_search_toggle
            build_search_filters
          end
          build_action_items
        end
      end

      def build_index_list
        indexes = active_admin_config.page_presenters[:index]
        if indexes.kind_of?(Hash) && indexes.length > 1
          index_classes = []
          current_index = nil
          active_admin_config.page_presenters[:index].each do |type, page_presenter|
            index_classes << find_index_renderer_class(page_presenter[:as])
            if current_index? find_index_renderer_class(page_presenter[:as])
              current_index = find_index_renderer_class(page_presenter[:as])
            end
          end
          div class: "display_selector dropdown_menu" do
            name = current_index.index_name
            a(class: "dropdown_menu_button nav-icon",
              "data-toggle" => 'tooltip',
              "data-placement" => 'bottom',
              "title" => "#{I18n.t('active_admin.display_as')}") do
              I18n.t("active_admin.index_list.#{name}", default: name.to_s.titleize).html_safe
            end
            div class: "dropdown_menu_list_wrapper" do
              index_list_renderer(index_classes)
            end
          end
        end
      end

      def current_index?(index_class)
        if params[:as]
          params[:as] == index_class.index_name
        else
          active_admin_config.default_index_class == index_class
        end
      end

      def find_index_renderer_class(klass)
        klass.is_a?(Class) ? klass :
          ::ActiveAdmin::Views.const_get("IndexAs" + klass.to_s.camelcase)
      end

      def any_table_tools?
        active_admin_config.batch_actions.any? ||
        active_admin_config.scopes.any? ||
        active_admin_config.page_presenters[:index].try(:size).try(:>, 1)
      rescue
        false
      end
    end
  end
end
