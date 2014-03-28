class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def create
    super
    unless @user.new_record?
      session[:omniauth] = nil
      session[:extra] = nil
    end
  end

  protected

  def build_resource(*args)
    super
    omni = session[:omniauth]
    if omni
      @user.first_name = session[:extra][:first_name]
      @user.username = session[:extra][:username]
      @user.apply_omniauth(omni)
      @user.valid?
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :username
  end
end
