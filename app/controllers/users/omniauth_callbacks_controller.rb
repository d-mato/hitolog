class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_or_create_social_profile, only: [:github, :google_oauth2, :twitter]

  def github
    redirect_to root_path
  end

  def google_oauth2
    redirect_to root_path
  end

  def twitter
    redirect_to root_path
  end

  private

  def set_or_create_social_profile
    auth = request.env['omniauth.auth']
    profile = SocialProfile.find_or_initialize_by(provider: auth['provider'], uid: auth['uid'])
    profile.oauth_data = auth
    profile.save!

    # ログイン中ならログインしているUserにSocialProfileを関連付けてreturn
    if signed_in?
      profile.update(user_id: current_user.id)
      return
    end

    user = profile.user || User.create_with_social_profile!(profile)

    # Userの作成に失敗
    unless user
      return redirect_to sign_in_path, flash: { warning: 'ユーザーの作成に失敗しました。お手数ですが管理者までお問い合わせください。' }
    end

    sign_in user
  end
end
