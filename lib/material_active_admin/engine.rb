require 'rubygems'
require 'active_admin/engine'
require 'select2-rails'
require 'tinymce-rails'

module MaterialActiveAdmin

  # initialize CbCore Engine
  class Engine < ::Rails::Engine

    ActiveAdmin.before_load do |app|
      require_relative 'extension/batch_actions/resource_extension'
      require_relative 'extension/batch_actions/views/batch_action_selector'
      ::ActiveAdmin::Resource.send :include, ActiveAdmin::BatchActions::ResourceExtension
      app.view_factory.register batch_action_selector:
        ::ActiveAdmin::BatchActions::BatchActionSelector
    end

    initializer 'initialize overrides' do |_app|
      require_view_helpers
      require_resources
      require_dsls
      require_views
      require_others
    end

    initializer 'initialize DSL' do |_app|
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::HiddenContent::DSL)
      ::ActiveAdmin::DSL.send(:include, ActiveAdmin::FloatActions::DSL)
    end

    initializer 'material_active_admin.assets.precompile' do |app|
      app.config.assets.precompile += %w[
        material_active_admin/cb-logo.png
        material_active_admin/tinymce/style.scss
      ]
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    def require_views
      require_each(view_files, 'views/')
      require_each(page_files, 'views/pages/')
      require_each(component_files, 'views/components/')
      require_each(filter_files, 'inputs/filters/base/')
    end

    def require_resources
      require_each(resource_files, 'resource/')
    end

    def require_view_helpers
      require_each(view_helpers, 'view_helpers/')
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
        columns blank_slate batch_action_menu scopes site_title bottom_sheet
        tabs table_for hidden_section dropdown_menu section attributes_table panel
        active_admin_form
      ]
    end

    def filter_files
      %w[search_method_select date_range_input]
    end

    def view_helpers
      %w[breadcrumb_helper]
    end

    def resource_files
      %w[hidden_content float_actions]
    end

    def dsl_files
      %w[hidden_content float_actions]
    end

    def other_files
      %w[
        hidden_section view_helpers action_items float_actions footer
        comment file view_factory resource page formastic/checkbox
      ]
    end

  end

end
