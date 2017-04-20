module ActiveAdmin
  module Views
    module Pages
      class Index < Base
        def add_classes_to_body
          @body.add_class(params[:action])
          @body.add_class(params[:controller].tr('/', '_'))
          @body.add_class("active_admin")
          @body.add_class("logged_in")
          @body.add_class(active_admin_namespace.name.to_s + "_namespace")
          @body.add_class("has_tabs") if any_table_tools?
        end

        def build_title_bar
          insert_tag view_factory.title_bar, title, action_items_for_action, true, {filters: filter_sections}
        end

        def build_table_tools
          div class: "table_tools" do
            build_scopes
            # build_index_list
          end if any_table_tools?
        end

        def build_scopes
          if active_admin_config.scopes.any?
            scope_options = {
              scope_count: config.fetch(:scope_count, true)
            }

            scopes_renderer active_admin_config.scopes, scope_options
          end
        end

        private

        def is_filter_section?(section)
          section.name.to_sym == :filters
        end

        def filter_sections
          sections = []
          sidebar_sections_for_action.collect do |section|
            next unless is_filter_section?(section)
            sections.push section
          end
          sections
        end

        def build_sidebar
          sections = []
          sidebar_sections_for_action.collect do |section|
            next if is_filter_section?(section)
            sections.push section
          end
          return unless sections.any?
          div id: "sidebar" do
            sections.collect do |section|
              sidebar_section(section)
            end
          end
        end

        def any_table_tools?
          active_admin_config.scopes.any?
          # active_admin_config.scopes.any? ||
          # active_admin_config.page_presenters[:index].try(:size).try(:>, 1)
        rescue
          false
        end

      end
    end
  end
end
