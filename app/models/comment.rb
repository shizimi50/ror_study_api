class Comment < ApplicationRecord
    validates :comment, :post_id, presence: true
    validates :comment, {length: {maximum: 255}}
    belongs_to :post
end
