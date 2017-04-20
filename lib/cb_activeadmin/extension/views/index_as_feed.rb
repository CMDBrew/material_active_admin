module ActiveAdmin
  module Views
    class IndexAsFeed < ActiveAdmin::Component

      def build(page_presenter, collection)
        @page_presenter = page_presenter
        @collection     = collection

        # Call the block passed in. This will set the
        # title and body methods
        instance_exec &page_presenter.block if page_presenter.block

        add_class "index mdi_index"
        build_posts
      end

      # Setter method for the configuration of the cover
      def cover(method = nil)
        @cover = method
      end

      # Setter method for the configuration of the title
      def title(method = nil)
        @title = method
      end

      # Setter method for the configuration of the meta
      def meta(method = nil)
        @meta = method
      end

      # Setter method for the configuration of the body
      #
      def body(method = nil, &block)
        @body = method
      end

      # Setter method for the configuration of the actions
      #
      def actions(method = nil, &block)
        @actions = method
      end

      def self.index_name
        "feed"
      end

      private

      def defaults(resource, options = {})
        if controller.action_methods.include?('show') && authorized?(ActiveAdmin::Auth::READ, resource)
          item I18n.t('active_admin.view'), resource_path(resource), class: "view_link #{options[:css_class]}", title: I18n.t('active_admin.view')
        end
        if controller.action_methods.include?('edit') && authorized?(ActiveAdmin::Auth::UPDATE, resource)
          item I18n.t('active_admin.edit'), edit_resource_path(resource), class: "edit_link #{options[:css_class]}", title: I18n.t('active_admin.edit')
        end
        if controller.action_methods.include?('destroy') && authorized?(ActiveAdmin::Auth::DESTROY, resource)
          item I18n.t('active_admin.delete'), resource_path(resource), class: "delete_link #{options[:css_class]}", title: I18n.t('active_admin.delete'),
            method: :delete, data: {confirm: I18n.t('active_admin.delete_confirmation')}
        end
      end

      def build_posts
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?
        @collection.each do |post|
          build_post(post)
        end
      end

      def build_post(post)
        div for: post, class: "mdi-card" do
          resource_selection_cell(post) if active_admin_config.batch_actions.any?
          build_actions(post)
          build_title(post)
          build_meta(post)
          build_cover(post)
          build_body(post)
        end
      end

      def build_actions(post)
        div class: "card-actions" do
          dropdown_menu "" do
            if @actions && block_given?
              instance_exec(post, @actions)
            else
              defaults(post)
            end
          end
        end
      end

      def build_cover(post)
        return unless @cover
        div class: "cover" do
          image_tag render_method_on_post_or_call_proc post, @cover
        end
      end

      def build_title(post)
        if @title
          h5 class: "title" do
            a(href: resource_path(post)) do
             render_method_on_post_or_call_proc post, @title
            end
          end
        else
          h5 do
            auto_link(post)
          end
        end
      end

      def build_meta(post)
        para class: "meta" do
          if @meta
            render_method_on_post_or_call_proc post, @meta
          else
            post.public_send :created_at
          end
        end
      end

      def build_body(post)
        return unless @body
        div class: 'body' do
          render_method_on_post_or_call_proc post, @body
        end
      end

      def render_method_on_post_or_call_proc(post, proc)
        case proc
        when String, Symbol
          post.public_send proc
        else
          instance_exec post, &proc
        end
      end

    end
  end
end
