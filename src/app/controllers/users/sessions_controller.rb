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
      # テストユーザーの情報（email）でログイン
      user = User.find_by(email: 'test@gmail.com')  # ユーザーのemailに適切な値を設定してください
      if user
        puts "Found user: #{user.email}"  # デバッグ出力を追加
        sign_in(user)
        puts "User signed in"
        redirect_to root_path, notice: 'テストユーザーとしてログインしました。'
      else
        puts "Test user not found"  # デバッグ出力を追加
        redirect_to new_user_session_path, alert: 'テストユーザーが見つかりませんでした。'
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
