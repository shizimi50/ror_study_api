class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title,null: false
      t.text :content,null: false
      t.string :name
      t.timestamps
    end
  end
end
