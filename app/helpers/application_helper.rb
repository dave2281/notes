module ApplicationHelper
  def notes_recaptcha
    if Note.where(created_at: Time.zone.today.all_day).count >= 3
      true
    else
      false
    end
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def json_filter(string_with_array)
    if string_with_array.present?
      JSON.parse(string_with_array)
    end
  end
  
  def user_id(note)
    note.user_id
  end
end
