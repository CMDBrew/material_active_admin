module ActiveAdmin

  module Inputs

    module Filters

      module Base

        module SearchMethodSelect

          def wrapper_html_options
            opts = super
            (opts[:class] ||= '') << ' select_and_search field-parts' unless seems_searchable?
            opts
          end

          def to_html
            input_wrapping do
              select_html <<
                input_html
            end
          end

          def input_html
            template.content_tag :div, class: 'field-part' do
              template.content_tag(:label, 'empty', class: 'label hidden') <<
                builder.text_field(current_filter, input_html_options)
            end
          end

          def select_html
            template.content_tag :div, class: 'field-part' do
              label_html <<
                template.select_tag('', template.options_for_select(filter_options, current_filter))
            end
          end

        end

      end

    end

  end

end
