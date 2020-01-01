# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end


    def twitter
      callback_from :twitter
    end

    def facebook
      callback_from :facebook
    end

    def facebook
      auth = request.env["omniauth.auth"]
      @user = User.where(provider: auth.provider, provider_uid: auth.uid).first
      unless @user
        @user = User.create(
            name:     auth.info.name,
            email:    fake_email(auth), # (ダミーのメールアドレスを生成)
            provider: auth.provider,
            provider_token:    auth.credentials.token,
            provider_uid: auth.uid,
            password: Devise.friendly_token[0,20],
        )
    end
  
  
      if @user.persisted?              # 以下はログイン処理
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        sign_in_and_redirect @user, event: :authentication
      else                             # 失敗した場合
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

   
    private
   
    def callback_from(provider)
      provider = provider.to_s
   
      @user = User.find_for_oauth(request.env['omniauth.auth'])
   
      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth'].except("extra")
        redirect_to new_user_registration_url
      end
    end


  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
