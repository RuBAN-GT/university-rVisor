module ScreenHelper
  # Get card with thumbnail
  def screen_card(screen)
    content_tag :div, "data-screen" => screen.id, :class => :card do
      link_to(image_tag(screen.image.thumb.url), screen.image.url, :target => :_blank, :class => :image) +
      content_tag(:div, '', :class => :content) do
        content_tag :div, "#{text_field_tag "screens[comments][#{screen.id}]", screen.comment, :placeholder => "Enter screenshot description"} #{icon_tag :edit}".html_safe, :class => 'description ui transparent left icon input'
      end +
      link_to("Delete #{icon_tag :trash}".html_safe, screen_path(screen), :remote => true, :method => :delete, :class => "ui bottom attached button")
    end.split(/\r?\n/).join.html_safe
  end
end
