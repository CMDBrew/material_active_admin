module ActiveAdmin
  module Views
    module Pages
      class Base < Arbre::HTML::Document
        def build_flash_messages
          div id: 'toast-container' do
            flash_messages.each do |type, message|
              div class: "toast flash_#{type}" do
                div class: "flash-message" do
                  div message.html_safe
                end
                div class: "toast-action" do
                  button class: "action" do
                    "close"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
