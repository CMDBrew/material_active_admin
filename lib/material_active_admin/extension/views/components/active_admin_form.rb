module ActiveAdmin

  module Views

    # Extending ActiveAdminForm Inputs
    class ActiveAdminForm < FormtasticProxy

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def inputs(*args, &block)
        form_builder.template.assigns[:has_many_block] = true if block_given?
        inputs_opts = args.extract_options!
        inputs_opts = format_inputs_opts(inputs_opts)
        if block_given? && block.arity.zero?
          wrapped_block =
            proc do
              wrap_it = form_builder.already_in_an_inputs_block ? true : false
              form_builder.already_in_an_inputs_block = true
              content =
                form_builder.template.capture do
                  yield
                end
              form_builder.already_in_an_inputs_block = wrap_it
              content
            end
          insert_tag(SemanticInputsProxy, form_builder, *(args << inputs_opts), &wrapped_block)
        else
          proxy_call_to_form(:inputs, *(args << inputs_opts), &block)
        end
      end

      private

      def format_inputs_opts(options)
        collapse = options.delete(:collapse) { true }
        hidden   = options.delete(:hidden) { false }
        options[:class] ||= ''
        inputs_class = ['inputs']
        inputs_class.push 'collapse' if collapse
        inputs_class.push 'hidden' if hidden
        options[:class] += inputs_class.join(' ')
        options
      end

    end

  end

end
