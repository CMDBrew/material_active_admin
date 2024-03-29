require 'material_active_admin/extension/resource/float_actions'
require 'material_active_admin/extension/resource/hidden_content'

module ActiveAdmin

  # Resource is the primary data storage for resource configuration in Active Admin
  #
  # When you register a resource (ActiveAdmin.register Post) you are actually creating
  # a new Resource instance within the given Namespace.
  #
  # The instance of the current resource is available in ResourceController and views
  # by calling the #active_admin_config method.
  #
  class Page

    include Resource::HiddenContent
    include Resource::FloatActions

  end

end
