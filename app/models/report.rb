class Report < ApplicationRecord
    belongs_to :user
    has_many :favorites

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end


    mount_uploader :image, ImageUploader

    validates :title, presence: true, length: { minimum: 3 }
    validates :image, presence: true
end
