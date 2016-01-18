class PublicController < ApplicationController
  layout "public.index", only: [:index]

  def index
  end

  def about
    @page = Page.find_by_slug 'about' || Page.new

    render template: "pages/show"
  end
  def about_title
    get_title_by_code("pages.about")
  end
end
