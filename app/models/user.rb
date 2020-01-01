class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2 twitter]

  mount_uploader :image, ImageUploader

  has_many :reports, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  
  # def self.find_for_oauth(auth)
  #   user = User.where(uid: auth.uid, provider: auth.provider).first
 
  #   unless user
  #     user = User.create(
  #       uid:      auth.uid,
  #       provider: auth.provider,
  #       email:    User.dummy_email(auth),
  #       password: Devise.friendly_token[0, 20],
  #       image: auth.info.image,
  #       username: auth.info.name,
  #     )
  #   end
 
  #   user
  # end

  def self.from_omniauth(auth)
    where(uid: auth.uid).first
  end

  def self.new_with_session(_, session)
    super.tap do |user|
      if (data = session['devise.omniauth_data'])
        user.email = data['email'] if user.email.blank?
        user.provider = data['provider'] if data['provider'] && user.provider.blank?
        user.uid = data['uid'] if data['uid'] && user.uid.blank?
        user.skip_confirmation!
      end
  end

  def self.search(search)
    if search
      User.where(['username LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  private
 
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
