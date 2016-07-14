module ApplicationHelper
  ### Actions

  def add_tag(path, icon='plus')
    link_to path, class: "btn btn-circle btn-default" do
      content = content_tag :i, nil, class: "fa fa-#{icon}"
      content << " #{t('global.links.add')}"
      content
    end
  end

  def edit_tag(path)
    link_to path, class: "btn btn-circle btn-sm btn-outline green" do
      content = content_tag :i, nil, class: 'fa fa-edit'
      content << " #{t('global.links.edit')}"
      content
    end
  end

  def delete_tag(path)
    link_to path, method: :delete, class: "btn btn-circle btn-sm btn-outline red" do
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
