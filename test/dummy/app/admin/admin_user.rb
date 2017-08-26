ActiveAdmin.register AdminUser do
  menu :parent => "integration",
       priority: 1,
       label: proc { menu_label("supervisor_account", "Admin Users", badge: 10) }

  permit_params :email,
                :password,
                :password_confirmation,
                :is_super_admin,
                :select,
                :textarea

  scope :basic_user, :show_count => true, :default => true do |records|
    records
  end
  scope :super_user, :show_count => true do |records|
    records
  end

  batch_action :hello, hidden_mobile: true do
    puts '132'
  end

  batch_action :world, dropdown_item: true do
    puts '132'
  end

  action_item :convert, only: :index, priority: 0 do
    nav_btn 'convert', '#'
  end
  action_item :convert, only: :index, priority: 0 do
    nav_btn 'convert', '#'
  end
  action_item :convert, only: :index, priority: 0 do
    nav_btn 'convert', '#'
  end

  action_item :drop, only: :show do
    dropdown_menu '' do
      item "Edit Details", '#'
      item "Edit My Account", '#'
    end
  end

  # FLOAT ACTIONS
  config.clear_float_actions!

  float_action :new, only: :index do
    if controller.action_methods.include?('new') &&
      authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
      float_item("add", 'add', '#')
    #   link_to content_tag(:i, 'add', class: 'material-icons'), new_resource_path
    end
  end

  float_action :new,
               only: :show do
    if controller.action_methods.include?('show') &&
       authorized?(ActiveAdmin::Auth::UPDATE, active_admin_config.resource_class)
      link_to '' do
        concat(content_tag(:i, 'mode_edit', class: 'material-icons'))
        concat('Edit')
      end
    end
  end

  float_action :new,
               only: :show do
    if controller.action_methods.include?('show') &&
       authorized?(ActiveAdmin::Auth::UPDATE, active_admin_config.resource_class)
      link_to '', class: 'brand-warning' do
        concat(content_tag(:i, 'videocam', class: 'material-icons'))
          concat('Video')
      end
    end
  end

  # sidebar :help, class: 'collapse' do
  #   "Need help? Email us at help@example.com"
  # end
  #
  # sidebar :help, class: 'collapse' do
  #   "Need help? Email us at help@example.com"
  # end
  #
  # sidebar :help, class: 'collapse' do
  #   "Need help? Email us at help@example.com"
  # end

  # scope :tab_3, :show_count => false do |records|
  #   records
  # end
  # scope :tab_4, :show_count => false do |records|
  #   records
  # end
  # scope :tab_5, :show_count => false do |records|
  #   records
  # end
  # scope :tab_6, :show_count => false do |records|
  #   records
  # end
  # scope :tab_7, :show_count => false do |records|
  #   records
  # end
  # scope :tab_8, :show_count => false do |records|
  #   records
  # end
  # scope :tab_9, :show_count => false do |records|
  #   records
  # end
  # scope :tab_10, :show_count => false do |records|
  #   records
  # end

  sidebar :message, only: :index, class: "collapse" do
    div do
      span do
        "Important Dates are updated"
      end
      b do
        "every day at 00:00 UTC"
      end
    end
  end

  sidebar :demo, class: "collapse" do
    div do
      para do
        "This is the demo app for Active Admin. Don't hesitate to check out the source code for this page, the Documentation and the Github Repo."
      end
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    # column :updated_at
    actions(dropdown: true, dropdown_name: nil)
  end

  # index as: :blog, label: "123" do
  #   title do |post|
  #     span post.email,      class: 'title'
  #     span post.created_at, class: 'created_at'
  #   end
  # end
  #
  # index as: :block do |product|
  #   div for: product do
  #     resource_selection_cell product
  #     h2  auto_link     product.email
  #     div simple_format product.textarea
  #   end
  # end

  filter :is_super_admin,
         :input_html => { class: "select2-with-search"}
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    tabs do
      tab "Detail" do
        panel "Admin User Details" do
          tabs do
            tab :inactive do
              section 'Interest Rate' do
                attributes_table_for admin_user do
                  row :email
                  row :sign_in_count
                  row :last_sign_in_at
                  row :last_sign_in_ip
                  row :updated_at
                  row :created_at
                end
              end
            end
            tab :active do
              section 'Beneficiaries' do
                attributes_table_for admin_user do
                  row :email
                  row :sign_in_count
                  row :last_sign_in_at
                  row :last_sign_in_ip
                  row :updated_at
                  row :created_at
                end
              end
            end
          end
        end
      end
      tab "Password" do
        panel "Admin User Details" do
          attributes_table_for admin_user do
            row :sign_in_count
            row :last_sign_in_at
            row :last_sign_in_ip
            row :updated_at
            row :created_at
          end
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    panel "Detail" do
      f.inputs do
        f.input :select,
                as: :select,
                collection: (1..100).map { |x| ["options - #{x}", "options - #{x}"]},
                :input_html => {class: "select2-with-search"},
                multiple: true,
                :hint => "ahsdioahsoidhaio oiashdoiashd oahsdo hadsoaoishd asiod ashiohds"
        f.input :is_super_admin
        f.input :email, input_html: { disabled: "disabled" }
        f.input :textarea, input_html: { rows: 4, class: "tinymce" }
        f.input :password
        f.input :password_confirmation
      end
      f.actions
    end
    # tabs do
    #   tab "Detail", {href: "123"} do
    #     panel "Detail", class: "collapse in" do
    #       section 'test' do
    #         tabs do
    #           tab "123" do
    #             f.inputs do
    #               f.input :select,
    #                       as: :select,
    #                       collection: (1..100).map { |x| ["options - #{x}", "options - #{x}"]},
    #                       :input_html => {class: "select2-with-search"},
    #                       multiple: true,
    #                       :hint => "ahsdioahsoidhaio oiashdoiashd oahsdo hadsoaoishd asiod ashiohds"
    #               f.input :is_super_admin
    #               f.input :email, input_html: { disabled: "disabled" }
    #               f.input :textarea, input_html: { rows: 4, class: "tinymce" }
    #               f.input :password
    #               f.input :password_confirmation
    #             end
    #           end
    #           tab "123" do
    #           end
    #         end
    #       end
    #       f.actions
    #     end
    #   end
    #   tab "Detail2", {href: "123"} do
    #     panel "Detail", class: "collapse in" do
    #       section 'test' do
    #         f.inputs do
    #           f.input :select,
    #                   as: :select,
    #                   collection: (1..100).map { |x| ["options - #{x}", "options - #{x}"]},
    #                   :input_html => {class: "select2-with-search"},
    #                   multiple: true
    #           f.input :is_super_admin
    #           f.input :email, input_html: { disabled: "disabled" }
    #           f.input :textarea, input_html: { rows: 4, class: "tinymce" }
    #           f.input :password
    #           f.input :password_confirmation
    #         end
    #       end
    #       f.actions
    #     end
    #   end
    # end
  end

end
