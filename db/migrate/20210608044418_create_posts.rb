class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :post_created_by, :default => '名無し'

      t.timestamps
    end
  end
end
