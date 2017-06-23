require 'active_admin/helpers/optional_display'

module ActiveAdmin

  class Resource

    # Register FloatAction Resource
    module FloatActions

      # Adds the default action items to a resource when it's initialized
      def initialize(*args)
        super
        add_default_float_actions
      end

      # @return [Array] The set of action items for this resource
      def float_actions
        @float_actions ||= []
      end

      # Add a new action item to a resource
      #
      # @param [Symbol] name
      # @param [Hash] options valid keys include:
      #                 :only:  A single or array of controller actions to display
      #                         this action item on.
      #                 :except: A single or array of controller actions not to
      #                          display this action item on.
      def add_float_action(name, options = {}, &block)
        float_actions << ActiveAdmin::FloatAction.new(name, options, &block)
      end

      def remove_float_action(name)
        float_actions.delete_if { |item| item.name == name }
      end

      # Returns a set of action items to display for a specific controller action
      #
      # @param [String, Symbol] action the action to retrieve action items for
      #
      # @return [Array] Array of FloatActions for the controller actions
      def float_actions_for(action, render_context = nil)
        float_actions.select { |item| item.display_on? action, render_context }
      end

      # Clears all the existing action items for this resource
      def clear_float_actions!
        @float_actions = []
      end

      # Used by active_admin Base view
      def float_actions?
        @float_actions && @float_actions.any?
      end

      private

      # Adds the default action items to each resource
      def add_default_float_actions
        add_default_new_float_action
        add_default_edit_float_action
      end

      # Adds the default New link on index
      def add_default_new_float_action
        add_float_action :new, only: :index do
          if controller.action_methods.include?('new') &&
             authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
            link_to(
              content_tag(:i, 'add', class: 'cb_activeadmin-icons'),
              new_resource_path
            )
          end
        end
      end

      # Adds the default Edit link on show
      def add_default_edit_float_action
        add_float_action :edit, only: :show do
          if controller.action_methods.include?('edit') &&
             authorized?(ActiveAdmin::Auth::UPDATE, resource)
            link_to(
              content_tag(:i, 'mode_edit', class: 'cb_activeadmin-icons'),
              edit_resource_path(resource)
            )
          end
        end
      end

    end

  end

  # Model class to store the data for FloatActions
  class FloatAction

    include ActiveAdmin::OptionalDisplay

    attr_accessor :block, :name

    def initialize(name, options = {}, &block)
      @name = name
      @options = options
      @block = block
      normalize_display_options!
    end

  end

end
