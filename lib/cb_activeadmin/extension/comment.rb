module ActiveAdmin
  module Comments
    module Views
      class Comments < ActiveAdmin::Views::Panel
        def build_comments
          div class: "comments-list" do
            @comments.any? ? @comments.each(&method(:build_comment)) : blank_slate_msg(new_resource_path=nil, resource_name=ActiveAdmin::Comment.model_name.human(count: 2))
          end
          build_comment_form
        end

        def build_comment(comment)
          div for: comment, class: "comment_item" do
            div class: "comment_item_inner" do
              div class: 'comment_avatar' do
                display_name(comment.author)[0]
              end
              div class: "comment_content" do
                div class: 'comment_header' do
                  div class: 'comment_meta' do
                    para class: 'comment_author' do
                      comment.author ? auto_link(comment.author) : I18n.t('active_admin.comments.author_missing')
                    end
                    div class: 'comment_date' do
                      span pretty_format comment.created_at
                    end
                  end
                end
                div class: 'comment_body' do
                  div comment.body, class: "comment_text"
                  div class: "comment_actions" do
                    if authorized?(ActiveAdmin::Auth::DESTROY, comment)
                      text_node link_to "", comments_url(comment.id), method: :delete, class: "comment-delete", data: { confirm: I18n.t('active_admin.comments.delete_confirmation') }
                    end
                  end
                end
              end
            end
          end
        end

        def build_comment_form
          active_admin_form_for(ActiveAdmin::Comment.new, url: comment_form_url, html: {class: "admin-comment-form"}) do |f|
            f.inputs do
              f.input :resource_type, as: :hidden,  input_html: { value: ActiveAdmin::Comment.resource_type(parent.resource) }
              f.input :resource_id,   as: :hidden,  input_html: { value: parent.resource.id }
              f.input :body,          label: false, input_html: { rows: '3', placeholder: "Your comments..." }
            end
            f.actions do
              f.action :submit, label: I18n.t('active_admin.comments.add')
            end
          end
        end
      end
    end
  end
end
