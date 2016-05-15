class SemanticBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    result = []

    @elements.each_with_index do |element, i|
      result << render_element(element, (@elements.count == i + 1))
    end

    if result.count > 1
      result.join.html_safe
    else
      ""
    end
  end

  def render_element(element, current = false)
    # current = @context.current_page?(compute_path(element))

    tag = (current) ? :div : :a

    @context.content_tag(tag, :class => "section #{(current) ? "active" : ""}") do
      link_or_text = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)

      divider = @context.content_tag(:span, (@options[:separator]  || '<div class="divider"> / </div>').html_safe, :class => 'divider') unless current

      link_or_text + (divider || '')
    end
  end
end
