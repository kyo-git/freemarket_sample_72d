class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_kana, :first_kana, :birth])
    devise_parameter_sanitizer.permit(:sign_up, keys: [place_attributes: [:post_code, :prefecture, :city_name, :address, :building] ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :last_name, :first_name, :last_kana, :first_kana, :birth])
    devise_parameter_sanitizer.permit(:account_update, keys: [place_attributes: [:post_code, :prefecture, :city_name, :address, :building] ])
  end

  private
  
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:BASIC_AUTH][:USER] && password == Rails.application.credentials[:BASIC_AUTH][:PASSWORD]
    end
  end

end
