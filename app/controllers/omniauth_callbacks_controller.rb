class OmniauthCallbacksController< Devise::OmniauthCallbacksController
  def twitter
    omni = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
      # User already authenticated
      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect authentication.user
    elsif current_user
      # User exists, but not authenticated
      token = omni['credentials']['token']
      token_secret = omni['credentials']['secret']

      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else
      # New user
      user = User.new
      user.apply_omniauth(omni)

      if user.save
        flash[:notice] = 'Logged in.'
        sign_in_and_redirect User.find(user.id)
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end
end
