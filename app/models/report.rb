class Report < ApplicationRecord
    belongs_to :user
    has_many :favorites, foreign_key: 'report_id', dependent: :destroy
    has_many :users, through: :favorites

    mount_uploader :image, ImageUploader

    validates :title, presence: true, length: { minimum: 3 }
    validates :image, presence: true
end
