class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  # universal method for strong parameters
  before_filter do
    resource = controller_name.singularize.to_sym
    method   = "#{resource}_params"

    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # core crumb
  before_filter do
    add_breadcrumb "public.index", :root_path, :titled => true
  end

  # redirect after sign in
  def after_sign_in_path_for(resource)
    cp_path
  end

  # redirect after sign out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # change devise layout
  protected
  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end

  # redirect for unauth (cancan)
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, :alert => exception.message
  end

  # titles
  helper_method :get_title
  def get_title_by_code(name = nil, *args)
    args = args.extract_options!

    I18n.t(
        name.blank? ?
            "structures.#{params[:controller]}.#{params[:action]}" :
            "structures.#{name.to_s}",
        args
    )
  end
  def get_title(name = nil)
    name ||= "#{params[:action]}_title"

    (respond_to? name) ? send(name) : get_title_by_code
  end

  # change breads method
  def add_breadcrumb(name = nil, path = nil, options = {})
    if options[:titled]
      name = get_title_by_code name, options[:title_args]
    end

    super name, path, options
  end
end
