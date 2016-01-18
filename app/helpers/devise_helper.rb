module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = content_tag(:div, class: "ui negative message") do
      content_tag(:div, "Внимание!", class: "header") +
        content_tag(:i, '', class: "close icon") +
        content_tag(
            :ul,
            resource.errors.map { |key, msg| content_tag(:li, msg) }.join.html_safe,
            class: "ul list"
        )
    end

    html.html_safe
  end
end