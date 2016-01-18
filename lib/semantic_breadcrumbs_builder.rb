class SemanticBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    unless @elements.blank? || @elements.length == 0
      @context.content_tag(:ul, class: 'ui breadcrumb') do
        @elements.collect do |element|
          render_element(element)
        end.join(@options[:separator] || '<div class="divider"> / </div>'.html_safe).html_safe
      end
    else
      ""
    end
  end

  def render_element(element)
    current = @context.current_page?(compute_path(element))

    @context.content_tag(:li, :class => 'section' + (current ? ' active' : '')) do
      if element.path == nil
        content = compute_name(element)
      else
        content = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      end
      if @options[:tag]
        @context.content_tag(@options[:tag], content)
      else
        content
      end
    end
  end
end