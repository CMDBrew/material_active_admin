require 'rubygems'
require 'active_admin/engine'
require 'select2-rails'
require 'tinymce-rails'

module CbActiveadmin

  # initialize CbCore Engine
  class Engine < ::Rails::Engine

    initializer 'initialize overrides' do |_app|
      require_resources
      require_dsls
      require_views
      require_others
    end

    initializer 'initialize DSL' do |_app|
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::HiddenContent::DSL)
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::FloatActions::DSL)
    end

    initializer 'cb_activeadmin.assets.precompile' do |app|
      app.config.assets.precompile += %w[cb_activeadmin/cb-logo.png]
    end

    def require_views
      require_each(view_files, 'views/')
      require_each(page_files, 'views/pages/')
      require_each(component_files, 'views/components/')
    end

    def require_resources
      require_each(resource_files, 'resource/')
    end

    def require_dsls
      require_each(dsl_files, 'dsl/')
    end

    def require_others
      require_each(other_files, '')
    end

    def require_each(files, path)
      files.each do |x|
        require_relative "extension/#{path}#{x}"
      end
    end

    def view_files
      %w[title_bar header action_items]
    end

    def page_files
      %w[base index flash]
    end

    def component_files
      %w[
        columns blank_slate app_header scopes site_title
        tabs table_for hidden_section
      ]
    end

    def resource_files
      %w[hidden_content float_actions]
    end

    def dsl_files
      %w[hidden_content float_actions]
    end

    def other_files
      %w[
        hidden_section view_helpers action_items float_actions
        comment file view_factory resource page formastic/checkbox
      ]
    end

  end

end
