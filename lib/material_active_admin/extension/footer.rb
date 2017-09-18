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
        I18n.t('material_active_admin.powered_by', owner: t('material_active_admin.owner')) +
          ' ' +
          I18n.t('material_active_admin.version', version: MaterialActiveAdmin::VERSION)
      end

    end

  end

end
