module ApplicationHelper
  # Show all messages
  #
  # @return [String] with html
  def flash_all
    result = []

    flash.each do |type, message|
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :error   if type == :alert

      if message.is_a? Array
        message.each do |spec|
          result << flash_block(spec, :type => type) unless spec == true || spec == false
        end
      else
        result << flash_block(message, :type => type) unless message == true || message == false
      end
    end

    result.join($/).html_safe
  end

  # Show message block
  #
  # @param [String] message
  # @param [Hash] options
  #
  # @return [String] html output
  def flash_block(message, options = {})
    case options[:type]
      when :success
        color = :positive
        options[:title] = t "template.flash.success" if options[:title].blank?
      when :error
        color = :negative
        options[:title] = t "tempalte.flash.error" if options[:title].blank?
      when :warning
        color = :warning
        options[:title] = t "tempalte.flash.warning" if options[:title].blank?
      else
        color = :info
        options[:title] = t "template.flash.info" if options[:title].blank?
        options[:type] = :info
    end

    content_tag :div,
      :class => "ui #{color} message",
      :data => { :type => options[:type] } do
      content_tag(:i, '', :class => "close icon") +
        content_tag(:h4, options[:title], :class => "ui header") +
        content_tag(:div, message, :class => "content")
    end
  end

  # Show icon tag with class
  #
  # @param [String] classes
  # @return [String] html
  def icon_tag(classes)
    content_tag :i, nil, :class => "#{classes.to_s} icon"
  end
end
