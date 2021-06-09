class Comment < ApplicationRecord
    validates :comment, :post_id, presence: true
    belongs_to :post
end
