module ActiveAdmin

  module FloatActions

    # Register in ActiveAdmin::DSL - activeadmin/lib/active_admin/dsl.rb
    module DSL

      def float_action(name, options = {}, &block)
        config.float_actions << ActiveAdmin::FloatAction.new(name, options, &block)
      end

    end

  end

end
