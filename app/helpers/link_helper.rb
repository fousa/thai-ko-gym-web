module LinkHelper
  def previous_link_to(path, month)
    link_to path, class: 'btn btn-circle btn-default previous' do
      content = content_tag :i, nil, class: 'fa fa-arrow-left'
      content << " #{l(month, format: :short_month)}"
      content
    end
  end

  def next_link_to(path, month)
    link_to path, class: 'btn btn-circle btn-default' do
      content = "#{l(month, format: :short_month)} "
      content << content_tag(:i, nil, class: 'fa fa-arrow-right')
      content.html_safe
    end
  end

  def icon_link_to(path, icon)
    link_to path, class: 'btn btn-circle btn-default', id: 'xls' do
      content_tag :i, nil, class: "fa fa-#{icon}"
    end
  end
end
