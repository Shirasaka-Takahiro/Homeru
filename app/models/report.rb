class Report < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search)
        if search
          Report.where(['title LIKE ?', "%#{search}%"])
        else
          Report.all
        end
    end


    mount_uploader :image, ImageUploader

    validates :title, presence: true, length: { maximum: 30 }
    validates :content, length: { maximum: 100 }
    validates :image, presence: { message: 'を選択してください' }
end
