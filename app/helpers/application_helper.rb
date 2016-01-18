module ApplicationHelper
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    active_class = html_options[:active] || "active"
    html_options.delete(:active)
    html_options[:class] = "#{html_options[:class]} #{active_class}" if current_page?(options)
    link_to(name, options, html_options, &block)
  end

  def path_breads
    path = request.path.split("/")[1..-1]

    if path
      res = "page_" + path.shift
    else
      res = "page_index"
    end

    if path
      path.each do |item|
        res += " #{res}_#{item}"
      end
    end

    res
  end
end

class ActionView::Helpers::FormBuilder
  def attr_errors?(attr)
    if object.errors.blank? || object.errors[attr].blank?
      false
    else
      true
    end
  end

  def attr_error_class(attr)
    if attr_errors? attr
      "error"
    else
      ""
    end
  end
end

SemanticFlashHelper.class_eval do
  def flash_container(type, message)
    content_tag(:div, class: "ui #{type} message") do
      content_tag(:h4, flash_name(type), class: "header") +
          content_tag(:i, '', class: "close icon") +
          message
    end
  end

  def flash_name(type)
    case type
      when :success
        "Успех!"
      when :error
        "Ошибка!"
      when :warning
        "Внимание!"
      else
        "Уведомление"
    end
  end
end