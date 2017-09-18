class BottomSheet < ActiveAdmin::Component
  builder_method :bottom_sheet

  # Build a new action list
  #
  # @param [String] name  The name to display in the button
  #
  # @param [Hash] options A set of options that get passed along to
  #                       to the parent dom element.
  def build(name, options = {})
    options = options.dup

    # Easily set options for the button or menu
    button_options = options.delete(:button) || {}
    menu_options = options.delete(:menu) || {}

    @button = build_button(name, button_options)
    @menu = build_menu(menu_options)

    super(options)
  end

  def item(title, url, options = {})
    icon = options.delete(:icon) { '' }
    within @menu do
      li class: 'bottom_sheet_item' do
        link_to url, options do
          content_tag(:i, '', class: "aa-icon-#{icon}") <<
            content_tag(:span, title)
        end
      end
    end
  end

  private

  def build_button(name, options)
    icon = options.delete(:icon) { 'more' }
    options[:class] ||= ''
    options[:class] << ' bottom_sheet_trigger float-btn'
    options[:href] = '#'

    a options do
      content_tag(:span, name)
      content_tag(:i, '', class: "aa-icon-#{icon}")
    end
  end

  def build_menu(options)
    options[:class] ||= ''
    menu_list = nil

    div class: 'bottom_sheet_wrapper' do
      menu_list = ul(options)
    end

    menu_list
  end

end
