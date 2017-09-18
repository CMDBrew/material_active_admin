module ActiveAdmin

  module HiddenContent

    # Register in ActiveAdmin::DSL - activeadmin/lib/active_admin/dsl.rb
    module DSL

      def hidden_content(name, options = {}, &block)
        config.hidden_sections << ActiveAdmin::HiddenSection.new(name, options, &block)
      end

    end

  end

end
