module ActiveAdmin

  module Views

    # Action List - A button with a drop down menu of links
    #
    # Creating a new action list:
    #
    #     dropdown_menu "Administration" do
    #       item "Edit Details", edit_details_path
    #       item "Edit My Account", edit_my_account_path
    #     end
    #
    # This will create a button with the label "Administration" and
    # a drop down once clicked with 2 options.
    #
    class BatchActionMenu < ActiveAdmin::Component

      builder_method :batch_action_menu

      # Build a new action list
      #
      # @param [String] name  The name to display in the button
      #
      # @param [Hash] options A set of options that get passed along to
      #                       to the parent dom element.
      # rubocop:disable Style/OptionHash
      def build(options = {})
        options = options.dup

        # Easily set options for the button or menu
        menu_options = options.delete(:menu) || {}

        @menu = build_menu(menu_options)

        super(options)
      end

      def item(*args)
        within @menu do
          li link_to(*args)
        end
      end

      private

      def build_menu(options)
        options[:class] ||= ''
        ul(options)
      end

    end

  end

end
