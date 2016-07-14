SimpleForm.setup do |config|
  # Wrappers
  config.wrappers :login_form, tag: 'div', class: 'form-group' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'control-label visible-ie8 visible-ie9'
    b.use :input, class: 'form-control form-control-solid placeholder-no-fix'
  end

  config.wrappers :metronic_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5

    b.use :label, class: 'control-label'
    b.use :input, class: 'form-control'
  end

  config.wrappers :metronic_checkbox, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5

    b.wrapper tag: 'label', class: 'mt-checkbox mt-checkbox-outline' do |bb|
      bb.use :label_text
      bb.use :input
      bb.use :span
    end
  end

  # Defaults
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn uppercase'
  config.boolean_label_class = nil
  config.boolean_style = :inline
  config.default_wrapper = :metronic_form
  config.wrapper_mappings = {
    boolean: :metronic_checkbox
  }
end
