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
      # New user. Add info to cookies (to pre-populate sign up form) and redirect to the sign up form.
      session[:omniauth] = omni.except('extra')
      raw_info = omni['extra']['raw_info']
      session[:extra] = {first_name: raw_info['name'], username: raw_info['screen_name']}
      redirect_to new_user_registration_path
    end
  end
end
