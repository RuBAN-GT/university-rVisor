class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception
  protect_from_forgery :with => :null_session

  before_action :devise_sub_layout

  # Handle none accessed
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message

    redirect_to "/"
  end

  add_breadcrumb "Home", :root_path

  # Adding validation errors to flash
  def render *args
    obj = instance_variable_get("@#{controller_name.classify.downcase}")

    if !obj.nil? && obj.errors.any?
      obj.errors.full_messages.each do |message|
        flash[:error] = message
      end
    end

    super
  end

  # Check user on current
  # @param [User|Integer] user
  # @return [Boolean]
  def is_current?(user)
    user = (user.is_a? User) ? user : User.find(user)

    !user.nil? && current_user.id == user.id
  end
  helper_method :is_current?

  # Set & get sub layout
  #
  # @param [String] name
  # @return [String]
  def sub_layout(name = nil)
    @sub_layout = name.to_s unless name.blank?

    @sub_layout
  end
  helper_method :sub_layout

  protected

    # Change devise sub layout
    def devise_sub_layout
      if devise_controller? && !user_signed_in?
        sub_layout(:devise_guest)
      end
    end

    # Take action only for current user
    #
    # @param [String] set nickname from parametrs
    def current_user_only!(set = nil)
      set ||= params[:nickname] || params[:user_nickname]
      if user_signed_in? && current_user.nickname != set
        raise ActionController::RoutingError.new('Not Found')
      end
    end
end
