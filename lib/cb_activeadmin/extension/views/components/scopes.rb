require 'active_admin/helpers/collection'
require 'active_admin/view_helpers/method_or_proc_helper'

module ActiveAdmin

  module Views

    # Overwriting ActiveAdmin::Scope - activeadmin/lib/active_admin/views/components/scopes.rb
    class Scopes < ActiveAdmin::Component

      builder_method :scopes_renderer

      # rubocop:disable Style/OptionHash
      def build(scopes, options = {})
        scopes.each do |scope|
          build_scope(scope, options) if call_method_or_proc_on(self, scope.display_if_block)
        end
      end

      protected

      def build_scope(scope, options)
        li class: classes_for_scope(scope) do
          a href: url_for(scope: scope.id, params: scope_params), class: 'table_tools_button' do
            text_node scope_name(scope)
            if should_render_scope?(scope, options)
              span get_scope_count(scope).to_s, class: 'count'
            end
          end
        end
      end

      private

      def scope_name(scope)
        I18n.t("active_admin.scopes.#{scope.id}", default: scope.name.to_s)
      end

      def scope_params
        request.query_parameters.except(
          :page,
          :scope,
          :commit,
          :format
        )
      end

      def should_render_scope?(scope, options)
        options[:scope_count] &&
          scope.show_count &&
          get_scope_count(scope).positive?
      end

    end

  end

end
