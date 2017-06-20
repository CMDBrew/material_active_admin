require 'active_admin/helpers/optional_display'

module ActiveAdmin

  class Resource

    # Register HiddenContent Resource
    module HiddenContent

      def hidden_sections
        @hidden_sections ||= []
      end

      def clear_hidden_sections!
        @hidden_sections = []
      end

      def hidden_sections_for(action, render_context = nil)
        hidden_sections.select do |section|
          section.display_on?(action, render_context)
        end.sort_by(&:priority)
      end

      def hidden_sections?
        @hidden_sections && @hidden_sections.any?
      end

    end

  end

end
