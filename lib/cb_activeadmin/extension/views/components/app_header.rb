require "cb_activeadmin/version"

module ActiveAdmin
  module Views

    class AppHeader < Component

      def tag_name
        'div'
      end

      def build(namespace)
        super(id: "app_header")
        @namespace = namespace

        if site_title_link?
          site_title_with_link
        else
          site_title_content
        end
      end

      def site_title_link?
        @namespace.site_title_link.present?
      end

      def favicon?
        @namespace.favicon.present?
      end

      private

      def site_title_with_link
        helpers.link_to(site_title_content, @namespace.site_title_link)
      end

      def site_title_content
        div class: "flex-col" do

        end
        div class: "flex-col" do
          div class: "favicon-container" do
            if favicon?
              div favicon, class: 'favicon'
            end
          end
          div class: "title" do
            title_text
          end
        end
        div class: "flex-col" do
          I18n.t('active_admin.version', version: CbActiveadmin::VERSION)
        end
      end

      def title_text
        helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title)
      end

      def favicon
        path = helpers.render_or_call_method_or_proc_on(helpers, @namespace.favicon)
        helpers.image_tag(path, id: "site_favicon", alt: title_text)
      end

    end

  end
end
