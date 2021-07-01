class Post < ApplicationRecord
    has_many :comments
    validates_associated:comments
    validates:title,presence: true
    validates:content,presence: true
    attr_accessor :count
    def count_post_id
        self.comments.count(:post_id)
    end
    def self.search(keyword)
        where(["title like? OR content like? OR name like?", "%#{keyword}%", "%#{keyword}%","%#{keyword}%"])
    end
end
