class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :report
    validates :content, presence: true
    validates :content, length: { maximum: 60 }
end
