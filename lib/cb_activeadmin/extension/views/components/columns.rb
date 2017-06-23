module ActiveAdmin

  module Views

    # Register Columns in Views
    class Columns < ActiveAdmin::Component

      builder_method :columns

      # For documentation, please take a look at Column#build
      def column(*args, &block)
        insert_tag Column, *args, &block
      end

      protected

      def closing_tag
        '' + super
      end

      def margin_size
        0
      end

    end

    # Register Column in Views
    class Column < ActiveAdmin::Component

      def set_column_styles(column_width, margin_width, _is_last_column = false)
        styles = []
        styles << "width: #{column_with_span_width(column_width, margin_width)}%;"
        styles << "max-width: #{safe_width(max_width)};" if max_width
        styles << "min-width: #{safe_width(min_width)};" if min_width
        set_attribute :style, styles.join(' ')
      end

      private

      def column_with_span_width(column_width, margin_width)
        (span_size * column_width) + ((span_size - 1) * margin_width)
      end

    end

  end

end
