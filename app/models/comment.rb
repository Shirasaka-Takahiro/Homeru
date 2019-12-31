class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :report
    validates :content, presence: true, ng_word: true
    validates :content, length: { maximum: 60 }
    validates :content,  obscenity: { sanitize: true, replacement: "[NGワードです]" }
end
