module ApplicationHelper
  ### Actions

  def back_tag(path)
    link_to path, class: 'btn btn-circle btn-default' do
      content = content_tag :i, nil, class: 'fa fa-long-arrow-left'
      content << " #{t('global.links.back')}"
      content
    end
  end

  def filter_tag(path, title = nil, icon = nil, &_block)
    filter_content = link_to path, class: 'btn btn-circle btn-default', data: { toggle: 'dropdown' } do
      content = content_tag :i, nil, class: "fa fa-#{icon || 'filter'}"
      content << " #{title || t('global.links.filter')} "
      content << content_tag(:i, nil, class: 'fa fa-angle-down')
      content
    end
    ul = content_tag :ul, class: 'dropdown-menu' do
      yield
    end
    filter_content << ul
    filter_content
  end

  def filter_item_tag(path, icon, title)
    content_tag :li do
      link_to path do
        content = content_tag :i, nil, class: "fa fa-#{icon}"
        content << " #{title}"
        content
      end
    end
  end

  def xls_tag(path, icon = 'file-excel-o')
    link_to path, class: 'btn btn-circle btn-warning btn-sm', id: 'xls' do
      content_tag :i, nil, class: "fa fa-#{icon}"
    end
  end

  def icon_link_to(path, icon)
    link_to path, class: 'btn btn-circle btn-default', id: 'xls' do
      content_tag :i, nil, class: "fa fa-#{icon}"
    end
  end

  def add_tag(path, icon = 'plus')
    link_to path, class: 'btn btn-circle btn-default' do
      content = content_tag :i, nil, class: "fa fa-#{icon}"
      content << " #{t('global.links.add')}"
      content
    end
  end

  def show_tag(path)
    link_to path, class: 'btn btn-circle btn-sm btn-outline blue' do
      content = content_tag :i, nil, class: 'fa fa-eye'
      content << " #{t('global.links.show')}"
      content
    end
  end

  def edit_tag(path, options = {})
    options = { class: 'btn btn-circle btn-sm btn-outline green' }.merge options
    link_to path, options do
      content = content_tag :i, nil, class: 'fa fa-edit'
      content << " #{t('global.links.edit')}"
      content
    end
  end

  def invite_tag(path, name)
    link_to path, method: :post, class: 'btn default', data: { confirm: t('global.labels.invite', name: name) } do
      content = content_tag :i, nil, class: 'fa fa-envelope'
      content << " #{t('global.links.invite').upcase}"
      content
    end
  end

  def delete_tag(path, name)
    link_to path, method: :delete, class: 'btn btn-circle btn-sm btn-outline red', data: { confirm: t('global.labels.delete', name: name) } do
      content = content_tag :i, nil, class: 'fa fa-trash'
      content << " #{t('global.links.delete')}"
      content
    end
  end

  ### Menu

  def menu_tag(title, path, active_controller)
    active = active_controller == controller_name
    content_tag :li, class: active ? 'active' : nil do
      link_to title, path
    end
  end

  def author_tag
    link_to 'fousa', 'http://fousa.be', target: '_BLANK', title: 'Crafting awesome (web)apps since 2005!'
  end

  def flash_tag
    if flash[:alert]
      content_tag 'div', class: 'alert alert-danger' do
        content_tag 'span', flash[:alert]
      end
    elsif flash[:notice]
      content_tag 'div', class: 'alert alert-success' do
        content_tag 'span', flash[:notice]
      end
    end
  end
end
