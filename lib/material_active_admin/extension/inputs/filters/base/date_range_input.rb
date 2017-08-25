module ActiveAdmin

  module Inputs

    module Filters

      class DateRangeInput < ::Formtastic::Inputs::StringInput

        include Base

        def wrapper_html_options
          opts = super
          (opts[:class] ||= '') << ' field-parts' unless seems_searchable?
          opts
        end

        def to_html
          input_wrapping do
            start_input_html <<
              end_input_html
          end
        end

        def start_input_html
          template.content_tag :div, class: 'field-part' do
            label_html <<
              builder.text_field(gt_input_name, input_html_options(gt_input_name, gt_input_placeholder))
          end
        end

        def end_input_html
          template.content_tag :div, class: 'field-part' do
            template.content_tag(:label, 'empty', class: 'label hidden') <<
              builder.text_field(lt_input_name, input_html_options(lt_input_name, lt_input_placeholder))
          end
        end

        def input_html_options(input_name = gt_input_name, placeholder = gt_input_placeholder)
          current_value =
            begin
              # cast value to date object before rendering input
              @object.public_send(input_name).to_s.to_date
            rescue
              nil
            end
          {
            size: 12,
            class: 'datepicker',
            maxlength: 10,
            placeholder: placeholder,
            value: current_value ? current_value.strftime('%Y-%m-%d') : ''
          }
        end

        def gt_input_placeholder
          I18n.t('active_admin.filters.predicates.from')
        end

        def lt_input_placeholder
          I18n.t('active_admin.filters.predicates.to')
        end

      end

    end

  end

end
