# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if verify_recaptcha
      super
    else
      flash[:alert] = "reCaptcha verification failed. Please try again."
      redirect_to new_user_session_path
    end
  end


  # DELETE /resource/sign_out
  def destroy
    signed_out = sign_out(resource_name)
    set_flash_message! :notice, :signed_out if signed_out
    redirect_to new_user_session_path
  end

  def logout_success
    redirect_to new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
