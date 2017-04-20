module ActiveAdmin::ViewHelpers
  def menu_label(icon, label, badge=nil)
    html = []
    html << content_tag(:i, icon, class: "cb_activeadmin-icons")
    html << (
      content_tag(:span, class: "menu-title") do
        content_tag(:span, label)
      end
    )
    if badge.is_a?(Integer) && badge.present? && badge != 0
      badge = "99+" if badge > 99
      html << content_tag(:span, badge, class: "mdi-chip brand-danger chip-densed")
    end
    html.join.html_safe
  end

  def admin_avatar(current_admin_user)
    html = []
    if current_admin_user.respond_to?(:avatar) && current_admin_user.avatar.present?
      html << content_tag(:div, class: "avatar-container") do
        content_tag :div, class: "avatar" do
          image_tag current_admin_user.avatar.url(:thumb)
        end
      end
    else
      html << content_tag(:div, class: "avatar-container") do
        content_tag :div, class: "avatar" do
          current_admin_user.email[0]
        end
      end
    end
    html << content_tag(:span, admin_identifier(current_admin_user))
    html.join.html_safe
  end

  def admin_identifier(current_admin_user)
    if current_admin_user.respond_to?(:full_name) &&
       current_admin_user.full_name.present?
      current_admin_user.full_name
    else
      current_admin_user.email
    end
  end

  def file_preview(object, name="image")
    return unless object.respond_to?(name.to_sym) && object.send(name.to_sym).present?
    fields = []
    fields << (content_tag(:span, "current attachment: "))
    fields << (link_to object.send(name.to_sym).file.filename, object.send(name.to_sym).url, target: "_blank")
    fields.join.html_safe
  end

  def image_preview(object, name="image", size=nil)
    return unless object.respond_to?(name.to_sym) && object.send(name.to_sym).present?
    size = size.present? ? size.to_sym : nil
    content_tag :div, class: "image" do
      image_tag object.send(name.to_sym).url(size)
    end
  end

  def blank_slate_msg(new_resource_path=nil, resource_name="Records", icon="inbox", title=I18n.t("active_admin.blank_slate.heading"), msg=I18n.t("active_admin.blank_slate.content", resource_name: resource_name))
    if new_resource_path.present?
      msg += " #{link_to("Create one", new_resource_path, class: "brand-link")}"
    end
    content_tag :div, class: "blank_slate_container" do
      concat(content_tag :i, icon, class: "cb_activeadmin-icons")
      concat(content_tag :h4, title, class: "title")
      concat(content_tag :span, msg.html_safe, class: "blank_slate")
    end
  end

  def tab_active?(target_tab)
    target_tab == params[:active_tab] ? "selected" : nil
  end

  def mdi_spinner(color_klass="")
    content_tag :div, class: "mdi-spinner #{color_klass}" do
      (1..12).each do |i|
        concat(content_tag :div, "", class: "mdi-circle mdi-circle#{i}")
      end
    end
  end
end
