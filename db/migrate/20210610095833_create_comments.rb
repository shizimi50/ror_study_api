class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :f_id
      t.string :name
      t.text :content
      t.timestamps
    end
  end
end