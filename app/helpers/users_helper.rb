module UsersHelper
  ### filter

  def current_filter_title
    return t('pages.users.filter.active') if action_name == 'active'
    return t('pages.users.filter.inactive') if action_name == 'inactive'

    nil
  end

  def current_filter_icon
    return 'check-circle' if action_name == 'active'
    return 'times-circle' if action_name == 'inactive'

    nil
  end

  ### sorting

  def sort_tag(column, title, options = {})
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    options = { class: column == sort_column ? "sorting_#{direction}" : 'sorting' }.merge(options)
    content_tag :th, options do
      link_to title, column: column, direction: direction, search: params[:search]
    end
  end

  ### icons

  def sex_tag(user)
    translation = t("enums.user.sex.#{user.sex}")
    if user.m?
      content_tag :i, " #{translation}", class: 'fa fa-male'
    else
      content_tag :i, " #{translation}", class: 'fa fa-female'
    end
  end

  def active_tag(user)
    content_tag :i, nil, class: 'fa fa-check-circle' if user.active?
  end
end
