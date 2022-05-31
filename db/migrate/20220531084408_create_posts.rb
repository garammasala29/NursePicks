class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :site_name
      t.string :image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :url, unique: true
  end
end
