class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  def like(report)
    favorites.find_or_create_by(report_id: report.id)
  end

  def unlike(report)
    favorite = favorites.find_by(report_id: report.id)
    favorite.destroy
  end

  def favreport?(report)
    self.favreports.include?(report)
  end

  has_many :reports, dependent: :destroy
  has_many :favorites
  has_many :favreports, through: :favorites, source: :report
  
end
