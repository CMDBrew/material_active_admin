module ActiveAdmin

  module Views

    # Register SiteTitle in Views
    class SiteTitle < Component

      def tag_name
        'div'
      end

      def build(namespace)
        super(id: 'site_title')
        @namespace = namespace

        build_toggle

        h3 class: 'title' do
          if site_title_link?
            site_title_with_link
          else
            title_text
          end
        end
      end

      def site_title_link?
        @namespace.site_title_link.present?
      end

      def site_title_image?
        @namespace.site_title_image.present?
      end

      private

      def site_title_with_link
        helpers.link_to(title_text, @namespace.site_title_link)
      end

      def build_toggle
        div id: 'sidebar-close' do
          i '', class: 'aa-icon-menu sidebar-toggle'
        end
      end

      def title_text
        helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title)
      end

      def title_image
        path = helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title_image)
        helpers.image_tag(path, id: 'site_title_image', alt: title_text)
      end

    end

  end

end
