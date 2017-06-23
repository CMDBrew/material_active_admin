module ActiveAdmin

  module Views

    # Register ActiveAdmin Extension FloatAction
    class FloatActions < ActiveAdmin::Component

      def build(float_actions)
        float_actions.each do |float_action|
          span class: 'float_action' do
            instance_exec(&float_action.block)
          end
        end
      end

    end

  end

end
