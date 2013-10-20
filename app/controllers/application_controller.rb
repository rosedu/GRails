class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def create_contact contact_params
    if contact_params[:user_id].nil?
      contact_params[:user_id] = current_user.id
    end
    @contact = Contact.new(contact_params)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email, :first_name, :last_name, :password, :uid, :name, :provider) }
  end
end
