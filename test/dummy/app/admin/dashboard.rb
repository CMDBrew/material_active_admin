ActiveAdmin.register_page 'Dashboard' do
  # menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  menu priority: 1,
       label: proc { menu_label(I18n.t('active_admin.dashboard'), icon: 'chart-donut') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      div class: 'blank_slate' do
        h3 I18n.t('active_admin.dashboard_welcome.welcome'), class: 'title'
        para I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
