# Extend ActiveAdmin ViewHelpers
# rubocop:disable Metric/ModuleLength
module ActiveAdmin::ViewHelpers

  def menu_label(icon, label, badge: nil, html: [])
    html << menu_icon(icon)
    html << menu_title(label)
    html << menu_badge(badge)
    safe_join(html)
  end

  def admin_avatar(current_admin_user, html: [])
    html << admin_avatar_icon(current_admin_user)
    html << admin_identifier(current_admin_user)
    safe_join(html)
  end

  def admin_identifier(current_admin_user)
    content_tag :span do
      if current_admin_user.respond_to?(:full_name) &&
         current_admin_user.full_name.present?
        current_admin_user.full_name
      else
        current_admin_user.email
      end
    end
  end

  def file_preview(object, name = 'image', fields: [])
    return unless file_preview?(object, name)
    fields << file_preview_label
    fields << file_preview_link(object, name)
    safe_join(fields)
  end

  def image_preview(object, name = 'image', size = nil)
    return unless image_preview?(object, name)
    size = size.present? ? size.to_sym : nil
    content_tag :div, class: 'image' do
      image_tag object.send(name.to_sym).url(size)
    end
  end

  def blank_slate_msg(
    new_resource_path = nil,
    resource_name = 'Records',
    icon  = 'empty',
    title = blank_slate_title,
    msg   = [blank_slate_body(resource_name)]
  )
    msg << blank_slate_new_resource_path(new_resource_path).to_s
    content_tag :div, class: 'blank_slate_container' do
      concat(content_tag(:i, '', class: "cb-aa-icon-#{icon}"))
      concat(content_tag(:h3, title, class: 'title'))
      concat(content_tag(:p, safe_join(msg), class: 'blank_slate'))
    end
  end

  def tab_active?(target_tab)
    target_tab == params[:active_tab] ? 'selected' : nil
  end

  def mdi_spinner(color_klass = '')
    content_tag :div, class: "mdi-spinner #{color_klass}" do
      (1..12).each do |i|
        concat(content_tag(:div, '', class: "mdi-circle mdi-circle#{i}"))
      end
    end
  end

  private

  def blank_slate_title
    I18n.t('active_admin.blank_slate.heading')
  end

  def blank_slate_body(resource_name)
    I18n.t('active_admin.blank_slate.content', resource_name: resource_name)
  end

  def blank_slate_new_resource_path(new_resource_path)
    return if new_resource_path.blank?
    link_to('Create one', new_resource_path, class: 'brand-link')
  end

  def image_preview?(object, name)
    object.respond_to?(name.to_sym) &&
      object.send(name.to_sym).present?
  end

  def file_preview?(object, name)
    object.respond_to?(name.to_sym) &&
      object.send(name.to_sym).present?
  end

  def file_preview_label
    content_tag(:span, 'current attachment: ')
  end

  def file_preview_link(object, name)
    link_to object.send(name.to_sym).file.filename, object.send(name.to_sym).url, target: '_blank'
  end

  def menu_icon(icon)
    content_tag(:i, icon, class: 'aa-icon')
  end

  def menu_title(label)
    content_tag(:span, class: 'menu-title') do
      content_tag(:span, label)
    end
  end

  def menu_badge(badge)
    return unless badge.is_a?(Integer) && badge.positive?
    badge = '99+' if badge > 99
    content_tag(:span, badge, class: 'cb-aa-badge')
  end

  def admin_avatar_icon(current_admin_user)
    content_tag :div, class: 'avatar-container' do
      content_tag :div, class: 'avatar' do
        if current_admin_user.respond_to?(:avatar) && current_admin_user.avatar.present?
          image_tag current_admin_user.avatar.url(:thumb)
        else
          current_admin_user.email[0]
        end
      end
    end
  end

end
