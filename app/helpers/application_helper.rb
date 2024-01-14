module ApplicationHelper
  def currently_at()
    render partial: 'shared/menu'
  end
  def full_title(page_title = '')
    base_title = "AskIt"

    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

end

