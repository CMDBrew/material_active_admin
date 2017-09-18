module ActiveAdmin

  module Views

    # Register AttributesTable in Views
    class AttributesTable < ActiveAdmin::Component

      builder_method :attributes_table_for

      def build(obj, *attrs)
        @collection     = Array.wrap(obj)
        @resource_class = @collection.first.class
        options = {}
        options[:for] = @collection.first if single_record?
        super(options)
        @table = table(class: 'aa-attributes-table')
        build_colgroups
        rows(*attrs)
      end

    end

  end

end
