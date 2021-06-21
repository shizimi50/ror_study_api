class Post < ApplicationRecord
    validates :title, :content, presence: true
    validates :title, {length: {maximum: 140}}
    validates :content, {length: {maximum: 1000}}
    has_many :comments, dependent: :destroy
end

