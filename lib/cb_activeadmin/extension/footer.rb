module ActiveAdmin

  module Views

    # Register Footer
    class Footer < Component

      private

      def powered_by_message
        I18n.t('active_admin.powered_by',
               active_admin: link_to('Clever Banana Studios Inc.', 'http://www.cleverbanana.com'),
               version: CbActiveadmin::VERSION).html_safe
      end

    end

  end

end
