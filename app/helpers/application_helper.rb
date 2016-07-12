module ApplicationHelper
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
