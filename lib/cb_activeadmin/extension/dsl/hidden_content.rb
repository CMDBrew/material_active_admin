module ActiveAdmin
  module HiddenContent
    module DSL

      def hidden_content(name, options = {}, &block)
        config.hidden_sections << ActiveAdmin::HiddenSection.new(name, options, &block)
      end

    end
  end
end
