module ActiveAdmin

  module Views

    module Pages

      # Overwriting Views::Pages::Index - activeadmin/lib/active_admin/views/pages/index.rb
      class Index < Base

        def add_classes_to_body
          super
          @body.add_class('has_tabs') if any_table_tools?
        end

        def build_title_bar
          insert_tag(
            view_factory.title_bar,
            title,
            action_items_for_action,
            true,
            filters: filter_sections
          )
        end

        def build_table_tools
          return unless any_table_tools?
          div class: 'table_tools' do
            build_scopes
            build_index_list
          end
        end

        def build_scopes
          return unless active_admin_config.scopes.any?
          scope_options = {
            scope_count: config.fetch(:scope_count, true)
          }

          scopes_renderer active_admin_config.scopes, scope_options
        end

        def build_batch_bar
          div id: 'batch_bar' do
            build_batch_actions_selector
          end
        end

        private

        def build_page
          within @body do
            div(id: 'wrapper') do
              components.each do |x|
                next if should_skip_component?(x)
                send(x)
              end
            end
          end
        end

        def components
          %i[
            build_unsupported_browser build_header build_batch_bar build_title_bar
            build_page_content build_float_ctrl build_hidden_content
          ]
        end

        def filter_section?(section)
          section.name.to_sym == :filters
        end

        def filter_sections
          sections = []
          sidebar_sections_for_action.collect do |section|
            next unless filter_section?(section)
            sections.push section
          end
          sections
        end

        def build_batch_actions_selector
          return unless active_admin_config.batch_actions.any?
          insert_tag view_factory.batch_action_selector, active_admin_config.batch_actions
        end

        def build_sidebar(sections: [])
          sidebar_sections_for_action.collect do |section|
            next if filter_section?(section)
            sections.push section
          end
          return unless sections.any?
          div id: 'sidebar' do
            sections.collect do |section|
              sidebar_section(section)
            end
          end
        end

        def any_table_tools?
          active_admin_config.scopes.any?
        rescue
          false
        end

      end

    end

  end

end
