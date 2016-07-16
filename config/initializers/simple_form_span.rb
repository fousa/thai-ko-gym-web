module SimpleForm
  module Components
    module Span
      def span(wrapper_options)
        template.content_tag(:span)
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Span)
