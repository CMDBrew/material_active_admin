module ActiveAdmin

  module Views

    module Pages

      # Extend Views::Pages::Base - activeadmin/lib/active_admin/views/pages/base.rb
      class Base < Arbre::HTML::Document

        def build_flash_messages
          div id: 'toast-container' do
            flash_messages.each do |type, message|
              div class: "toast flash_#{type}" do
                toast_message(message)
                toast_action
              end
            end
          end
        end

        private

        def toast_action
          div class: 'toast-action' do
            button(class: 'action') { 'close' }
          end
        end

        def toast_message(message)
          div class: 'flash-message' do
            div { safe_join([message]) }
          end
        end

      end

    end

  end

end
