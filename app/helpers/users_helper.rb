module UsersHelper
  def sex_tag(user)
    translation = t("enums.user.sex.#{user.sex}")
    if user.m?
      content_tag :i, " #{translation}", class: 'fa fa-male'
    else
      content_tag :i, " #{translation}", class: 'fa fa-female'
    end
  end

  def active_tag(user)
    if user.active?
      content_tag :i, nil, class: 'fa fa-check-circle'
    end
  end
end
