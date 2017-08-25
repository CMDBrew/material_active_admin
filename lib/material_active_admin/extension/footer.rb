module ActiveAdmin

  module Views

    # Register Footer
    class Footer < Component

      def build(namespace)
        super id: 'footer'
        @namespace = namespace

        if footer?
          h6 footer_text
        else
          h6 powered_by_message
        end
      end

      private

      def powered_by_message
        I18n.t('active_admin.powered_by',
               owner: t('active_admin.owner'),
               version: MaterialActiveAdmin::VERSION)
      end

    end

  end

end
