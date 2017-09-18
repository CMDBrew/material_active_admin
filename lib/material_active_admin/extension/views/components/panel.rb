module ActiveAdmin

  module Views

    # Register Panel
    class Panel < ActiveAdmin::Component

      builder_method :panel

      def build(title, attributes = {})
        collapse = attributes.delete(:collapse) { true }
        hidden   = attributes.delete(:hidden) { false }
        super(attributes)
        add_class 'panel'
        add_class 'collapse' if collapse
        add_class 'hidden' if hidden
        @title = h3(title.to_s)
        @contents = div(class: 'panel_contents')
      end

    end

  end

end
