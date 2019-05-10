class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def facebook
    @user = SnsCredential.find_for_facebook(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?

    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      render template: 'devise/registrations/new_sns'
    end
  end
  def failure
    redirect_to root_path and return
  end



  def google_oauth2
    @user = SnsCredential.find_for_google_oauth2(request.env["omniauth.auth"].except(:extra))

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "google_oauth2") if is_navigational_format?

    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra")
      render template: 'devise/registrations/new_sns'

    end
  end
  def failure
    redirect_to root_path and return
  end
end
