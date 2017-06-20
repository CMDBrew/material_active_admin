module ActiveAdmin

  module Views

    module Pages

      # Overwriting Views:Pages::Base - activeadmin/lib/active_admin/views/pages/base.rb
      class Base < Arbre::HTML::Document

        private

        delegate :active_admin_config, :controller, :params, to: :helpers
        alias default_add_classes_to_body add_classes_to_body

        def add_classes_to_body
          default_add_classes_to_body
          @body.set_attribute('lang', I18n.locale)
        end

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
            build_unsupported_browser build_app_header build_header build_title_bar
            build_page_content build_footer build_float_ctrl build_hidden_content
          ]
        end

        def should_skip_component?(component)
          (component.to_s == 'build_float_ctrl' && skip_float_ctrl?) ||
            (component.to_s == 'build_hidden_content' && skip_hidden_content?)
        end

        def build_app_header
          insert_tag view_factory.app_header, active_admin_namespace
        end

        def hidden_sections_for_action
          if active_admin_config && active_admin_config.hidden_sections?
            active_admin_config.hidden_sections_for(params[:action], self)
          else
            []
          end
        end

        def float_actions_for_action
          if active_admin_config && active_admin_config.float_actions?
            active_admin_config.float_actions_for(params[:action], self)
          else
            []
          end
        end

        def build_hidden_content
          div id: 'hidden_content' do
            hidden_sections_for_action.collect do |section|
              hidden_section(section)
            end
          end
        end

        def build_float_ctrl
          klass = float_actions_for_action.length > 1 ? 'multi-actions' : nil
          div(id: 'float_actions', class: klass) { build_float_actions }
        end

        def skip_sidebar?
          sidebar_sections_for_action.empty? || assigns[:skip_sidebar] == true
        end

        def skip_hidden_content?
          hidden_sections_for_action.empty? || assigns[:skip_hidden_content] == true
        end

        def skip_float_ctrl?
          float_actions_for_action.empty? || assigns[:skip_float_ctrl] == true
        end

        def build_footer
          insert_tag view_factory.footer, active_admin_namespace
        end

        def build_float_actions
          insert_tag view_factory.float_actions, float_actions_for_action
        end

      end

    end

  end

end
