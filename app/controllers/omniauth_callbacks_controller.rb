class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url

    @user.last_name = session["devise.facebook_data"][:extra][:raw_info][:last_name]
    @user.first_name = session["devise.facebook_data"][:extra][:raw_info][:first_name]
    @user.url = session["devise.facebook_data"][:extra][:raw_info][:link]
    @user.save
    redirect_to root_path
    end
  end
end
