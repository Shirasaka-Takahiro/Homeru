class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook twitter]

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
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username
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
