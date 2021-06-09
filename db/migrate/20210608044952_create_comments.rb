class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :comment, :null => false
      t.string :comment_created_by, :default => '名無し'
      t.integer :post_id, :null => false
      
      t.timestamps
    end
  end
end
