# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      if params[:test_user]
        test_email = case params[:test_user]
                     when 'true'
                       'test@gmail.com'
                     when 'test1'
                       'test1@gmail.com'
                     else
                       nil
                     end
    
        user = User.find_by(email: test_email) if test_email
        if user
          sign_in(user)
          redirect_to root_path
        else
          redirect_to new_user_session_path, alert: 'Test user not found'
        end
      else
        super
      end
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
