module ActiveAdmin

  module BatchActions

    # Overwriting activeadmin/lib/active_admin/batch_actions/views/batch_action_selector.rb
    # rubocop:disable Metric/ClassLength
    class BatchActionSelector < ActiveAdmin::Component

      builder_method :batch_action_selector

      # Build a new batch actions selector
      #
      # @param [Array] batch_actions An array of batch actions
      def build(batch_actions)
        @batch_actions = Array(batch_actions)
        build_batch_bar_left
        @actions = build_actions
        @drop_down = build_drop_down
      end

      # We don't want to wrap the action list (or any other children) in
      # an unnecessary div, so instead we just return the children
      delegate :to_s, to: :children

      private

      def build_batch_bar_left
        div id: 'batch_bar_left' do
          build_selection_toggle
          h3 id: 'page_title' do
            span class: 'count'
            span 'selected'
          end
        end
      end

      def build_selection_toggle
        div id: 'selection-toggle', class: 'nav-icon' do
          i 'arrow_back', class: 'mdi-icon'
        end
      end

      def build_actions
        items = batch_actions_to_display.reject(&:dropdown_item)
        return if items.empty?
        batch_action_menu id: 'batch_bar_right',
                          class: 'batch_actions_selector',
                          button: { class: 'disabled' } do
          items.each do |batch_action|
            build_action(batch_action)
          end
        end
      end

      # rubocop:disable Metric/MethodLength, Metric/AbcSize
      def build_drop_down
        items = dropdown_items + hidden_mobile_items
        return if items.empty?
        dropdown_menu '', class: "batch_actions_selector dropdown_menu #{extra_dropdown_klass}",
                          button: { class: 'nav-icon' } do
          hidden_mobile_items.each do |batch_action|
            build_drop_down_action(batch_action)
          end
          divider('visible-mobile')
          dropdown_items.each do |batch_action|
            build_drop_down_action(batch_action)
          end
        end
      end

      def build_drop_down_action(batch_action)
        options = {
          :class         => "batch_action #{dropdown_action_klass(batch_action)}",
          'data-action'  => batch_action.sym,
          'data-confirm' => render_or_call_method_or_proc_on(self, batch_action.confirm),
          'data-inputs'  => render_in_context(self, batch_action.inputs).to_json
        }

        default_title = render_or_call_method_or_proc_on(self, batch_action.title)
        title = I18n.t("active_admin.batch_actions.labels.#{batch_action.sym}",
                       default: default_title)

        item title, '#', options
      end

      def build_action(batch_action)
        options = {
          :class         => "batch_action #{action_klass(batch_action)}",
          'data-action'  => batch_action.sym,
          'data-confirm' => render_or_call_method_or_proc_on(self, batch_action.confirm),
          'data-inputs'  => render_in_context(self, batch_action.inputs).to_json
        }

        if batch_action.icon.present?
          options.merge(
            'data-toggle'         => 'tooltip',
            'data-placement'      => 'bottom',
            'data-original-title' => action_title(batch_action)
          )
          item action_icon(batch_action.icon), '#', options
        else
          item action_title(batch_action), '#', options
        end
      end

      def extra_dropdown_klass
        dropdown_items.empty? ? 'visible-mobile' : nil
      end

      def dropdown_items
        batch_actions_to_display.select(&:dropdown_item)
      end

      def hidden_mobile_items
        batch_actions_to_display.select(&:hidden_mobile)
      end

      def dropdown_action_klass(batch_action)
        batch_action.hidden_mobile ? 'visible-mobile' : nil
      end

      def action_klass(batch_action)
        klass = []
        klass.push(batch_action.icon.present? ? 'nav-icon' : 'nav-btn')
        klass.push(batch_action.hidden_mobile ? 'hidden-mobile' : nil)
        klass.join(' ').strip
      end

      def action_title(batch_action)
        default_title = render_or_call_method_or_proc_on(self, batch_action.title)
        I18n.t(
          "active_admin.batch_actions.labels.#{batch_action.sym}",
          default: default_title
        )
      end

      def action_icon(icon)
        content_tag(:i, icon, class: 'aa-icon')
      end

      # Return the set of batch actions that should be displayed
      def batch_actions_to_display
        @batch_actions.select do |batch_action|
          call_method_or_proc_on(self, batch_action.display_if_block)
        end
      end

    end

  end

end
