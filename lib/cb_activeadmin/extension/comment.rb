module ActiveAdmin

  module Comments

    module Views

      # Overwriting ActiveAdmin Comments -
      # activeadmin/lib/active_admin/orm/active_record/comments/views/active_admin_comments.rb
      class Comments < ActiveAdmin::Views::Panel

        protected

        def build_comments
          div class: 'comments-list' do
            if @comments.any?
              @comments.each(&method(:build_comment))
            else
              blank_slate_msg(nil, ActiveAdmin::Comment.model_name.human(count: 2))
            end
          end
          build_comment_form
        end

        def build_comment(comment)
          div for: comment, class: 'comment_item' do
            div class: 'comment_item_inner' do
              comment_author_avatar(comment)
              comment_body(comment)
            end
          end
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def build_comment_form
          active_admin_form_for(
            ActiveAdmin::Comment.new,
            url: comment_form_url,
            html: { class: 'admin-comment-form' }
          ) do |f|
            f.inputs do
              f.input :resource_type,
                      as: :hidden,
                      input_html: { value: ActiveAdmin::Comment.resource_type(parent.resource) }
              f.input :resource_id,
                      as: :hidden,
                      input_html: { value: parent.resource.id }
              f.input :body,
                      label: false,
                      input_html: { rows: '3', placeholder: 'Your comments...' }
            end
            f.actions do
              f.action :submit, label: I18n.t('active_admin.comments.add')
            end
          end
        end

        private

        def comment_body(comment)
          div class: 'comment_content' do
            comment_meta(comment)
            div class: 'comment_body' do
              div comment.body, class: 'comment_text'
            end
          end
        end

        def comment_meta(comment)
          div class: 'comment_header' do
            comment_author(comment)
            comment_date(comment)
            comment_actions(comment)
          end
        end

        def comment_author_avatar(comment)
          div class: 'comment_avatar' do
            display_name(comment.author)[0]
          end
        end

        def comment_author(comment)
          h5 class: 'comment_author' do
            if comment.author
              auto_link(comment.author)
            else
              I18n.t('active_admin.comments.author_missing')
            end
          end
        end

        def comment_date(comment)
          div class: 'comment_date' do
            span pretty_format comment.created_at
          end
        end

        def comment_actions(comment)
          div class: 'comment_actions' do
            dropdown_menu '' do
              if authorized?(ActiveAdmin::Auth::DESTROY, comment)
                comment_action_delete(comment)
              end
            end
          end
        end

        def comment_action_delete(comment)
          item(
            I18n.t('active_admin.comments.delete'), comments_url(comment.id),
            method: :delete, class: 'comment-delete',
            data: { confirm: I18n.t('active_admin.comments.delete_confirmation') }
          )
        end

      end

    end

  end

end
