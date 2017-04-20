module ActiveAdmin
  module FloatActions
    module DSL

      def float_action(name, options = {}, &block)
        config.float_actions << ActiveAdmin::FloatAction.new(name, options, &block)
      end

    end
  end
end
