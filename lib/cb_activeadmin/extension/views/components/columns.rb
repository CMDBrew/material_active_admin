module ActiveAdmin
  module Views
    class Columns < ActiveAdmin::Component
      builder_method :columns

      # For documentation, please take a look at Column#build
      def column(*args, &block)
        insert_tag Column, *args, &block
      end

      protected

      def closing_tag
        "" + super
      end

      def margin_size
        0
      end

    end

    class Column < ActiveAdmin::Component
      def set_column_styles(column_width, margin_width, is_last_column = false)
        column_with_span_width = (span_size * column_width) + ((span_size - 1) * margin_width)

        styles = []

        styles << "width: #{column_with_span_width}%;"

        if max_width
          styles << "max-width: #{safe_width(max_width)};"
        end

        if min_width
          styles << "min-width: #{safe_width(min_width)};"
        end

        # styles << "margin-right: #{margin_width}%;" unless is_last_column

        set_attribute :style, styles.join(" ")
      end
    end
  end
end
