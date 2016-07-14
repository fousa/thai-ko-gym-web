module SimpleForm
  module Components
    module Span
      def span
        template.content_tag(:span)
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Span)
