class Report < ApplicationRecord
    belongs_to :user

    mount_uploader :image, ImageUploader

    validates :title, presence: true, length: { minimum: 3 }
    validates :image, presence: true
end
