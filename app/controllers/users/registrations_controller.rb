# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
    skip_before_action :require_no_authentication, only: [:new, :create]

    def new
      @user = User.new

    end

    # POST /resource
    def create
      build_resource(sign_up_params)
      @user = resource
      resource.save
      ApplicationMailer.welcome_email(resource).deliver
      ApplicationMailer.welcome_email_copy(resource).deliver
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
          redirect_to "/users/#{@user.slug}", notice: 'Application successfully accepted.'
        else
          expire_data_after_sign_in!
          redirect_to "/users/#{@user.slug}", notice: 'Application successfully accepted.'
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        redirect_to "/users/#{@user.slug}", notice: 'Application successfully accepted.'
      end
    end

    def sign_up(resource_name, resource)
      true
    end

    protected

    # def after_sign_up_path_for(resource)
    #   users_path
    # end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      "/submitted/"
    end

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
