# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  def blob(object, image_size:, blob_size: 'xs', name: 'image', round: false)
    return unless object.respond_to?(name.to_sym) && object.try(name.to_sym).present?
    klass = %w[blob]
    klass.push blob_size
    klass.push 'round' if round
    klass.join(' ')
    content_tag :div, class: klass do
      image_tag object.send(name.to_sym).url(image_size)
    end
  end

  def file_link(object, name: 'file')
    return unless file_link?(object, name)
    file_preview_label + file_preview_link(object, name)
  end

  def menu_label(label, icon: nil, badge: 0)
    safe_join [
      aa_icon(icon),
      menu_title(label),
      menu_badge(badge)
    ]
  end

  def aa_icon(icon)
    return if icon.blank?
    content_tag(:i, '', class: "aa-icon-#{icon}")
  end

  def blank_slate_msg(
    new_resource_path: nil,
    resource_name: 'Records',
    icon: 'empty',
    title: blank_slate_title,
    msg: [blank_slate_body(resource_name)]
  )
    msg << blank_slate_new_resource_path(new_resource_path).to_s
    content_tag :div, class: 'blank_slate_container' do
      concat(aa_icon(icon))
      concat(content_tag(:h3, title, class: 'title'))
      concat(content_tag(:p, safe_join(msg, ' '), class: 'blank_slate'))
    end
  end

  def tab_active?(target_tab)
    target_tab == params[:active_tab]
  end

  def select_tab?(target_tab)
    return unless tab_active?(target_tab)
    'selected'
  end

  def spinner(klass: 'brand-primary')
    content_tag :div, class: "aa-spinner #{klass}" do
      12.times do
        concat(content_tag(:div, '', class: 'circle'))
      end
    end
  end

  def admin_menu_label(user)
    (blob(user, image_size: 'thumb', name: 'avatar', round: true) || aa_icon('account-circle')) +
      admin_identifier(user)
  end

  def admin_identifier(user)
    identifier = user.respond_to?(:full_name) ? user.full_name : user.email
    content_tag(:div, class: 'menu-title', id: 'current-admin-menu') do
      content_tag(:span, identifier)
    end
  end

  private

  def blank_slate_title
    I18n.t('material_active_admin.blank_slate.heading')
  end

  def blank_slate_body(resource_name)
    I18n.t('material_active_admin.blank_slate.content', resource_name: resource_name)
  end

  def blank_slate_link
    I18n.t('material_active_admin.blank_slate.link')
  end

  def blank_slate_new_resource_path(new_resource_path)
    return if new_resource_path.blank?
    link_to(blank_slate_link, new_resource_path)
  end

  def file_link?(object, name)
    object.respond_to?(name.to_sym) &&
      object.send(name.to_sym).present?
  end

  def file_preview_label
    content_tag(:span, I18n.t('material_active_admin.file_preview.label'))
  end

  def file_preview_link(object, name)
    link_to object.send("#{name}_identifier".to_sym), object.send(name.to_sym).url, target: '_blank'
  end

  def menu_title(label)
    content_tag(:span, class: 'menu-title') do
      content_tag(:span, label)
    end
  end

  def menu_badge(badge)
    return unless badge.is_a?(Integer) && badge.positive?
    badge = '99+' if badge > 99
    content_tag(:span, badge, class: 'aa-badge')
  end

end
