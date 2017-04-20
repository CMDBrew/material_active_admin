module ActiveAdmin
  module Views

    class HiddenSection < ActiveAdmin::Component
      builder_method :hidden_section

      # Takes a ActiveAdmin::SidebarSection instance
      def build(section)
        @section  = section
        @contents = div(class: "hidden_contents")
        add_class @section.custom_class if @section.custom_class
        self.id = @section.id
        build_hidden_content
      end

      # Renders attributes_table_for current resource
      def attributes_table(*args, &block)
        attributes_table_for resource, *args, &block
      end

      def add_child(child)
        if @contents
          @contents << child
        else
          super
        end
      end

      # Override children? to only report children when the panel's
      # contents have been added to. This ensures that the panel
      # correcly appends string values, etc.
      def children?
        @contents.children?
      end

      protected

      def build_hidden_content
        if @section.block
          rvalue = instance_exec(&@section.block)
          self << rvalue if rvalue.is_a?(String)
        else
          render(@section.partial_name)
        end
      end
    end

  end
end
