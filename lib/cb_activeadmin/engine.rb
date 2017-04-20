require 'rubygems'
require 'active_admin/engine'
require 'select2-rails'
require 'tinymce-rails'

module CbActiveadmin
  class Engine < ::Rails::Engine
    initializer "initialize overrides" do |app|
      require_relative 'extension/resource/hidden_content'
      require_relative 'extension/resource/float_actions'
      require_relative 'extension/dsl/hidden_content'
      require_relative 'extension/dsl/float_actions'
      require_relative 'extension/hidden_section'
      require_relative 'extension/views/components/columns'
      require_relative 'extension/views/components/blank_slate'
      require_relative 'extension/views/components/app_header'
      require_relative 'extension/views/components/scopes'
      require_relative 'extension/views/components/site_title'
      require_relative 'extension/views/components/tabs'
      require_relative 'extension/views/components/table_for'
      require_relative 'extension/views/components/hidden_section'
      require_relative 'extension/views/pages/base'
      require_relative 'extension/views/pages/index'
      require_relative 'extension/views/pages/flash'
      require_relative 'extension/views/title_bar'
      require_relative 'extension/views/header'
      require_relative 'extension/views/index_as_feed'
      require_relative 'extension/views/index_as_gallery'
      require_relative 'extension/views/index_as_folder'
      require_relative 'extension/views/index_list'
      require_relative 'extension/view_helpers'
      require_relative 'extension/action_items'
      require_relative 'extension/float_actions'
      require_relative 'extension/comment'
      require_relative 'extension/file'
      require_relative 'extension/view_factory'
      require_relative 'extension/resource'
      require_relative 'extension/page'
      require_relative 'extension/formastic/checkbox'
    end

    initializer "initialize DSL" do |app|
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::HiddenContent::DSL)
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::FloatActions::DSL)
    end

    initializer "cb_activeadmin.assets.precompile" do |app|
      app.config.assets.precompile += %w(cb_activeadmin/cb-logo.png)
    end

  end
end
