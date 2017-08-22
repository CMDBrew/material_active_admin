module ActiveAdmin

  module Views

    # Register ActiveAdmin Extension Section
    class Section < ActiveAdmin::Component

      builder_method :section

      def build(title, attributes = {})
        super(attributes)
        add_class 'section'
        @title = h5(title.to_s, class: 'section-title')
        @contents = div(class: 'section_contents')
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

      def header_action(*args)
        action = args[0]

        @title << div(class: 'header_action') do
          action
        end
      end

    end

  end

end
