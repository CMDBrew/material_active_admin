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

        if site_title_link?
          site_title_with_link
        else
          site_title_content
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
        helpers.link_to(site_title_content, @namespace.site_title_link)
      end

      def site_title_content
        div(class: 'favicon-container') do
          div(title_icon, class: 'favicon')
        end
        div(class: 'title') do
          title_text
        end
        div(id: 'sidebar-close') do
          i('close', class: 'cb_activeadmin-icons')
        end
      end

      def title_text
        helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title)
      end

      def title_image
        path = helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title_image)
        helpers.image_tag(path, id: 'site_title_image', alt: title_text)
      end

      def title_icon
        site_title_image? ? title_image : title_text[0]
      end

    end

  end

end
