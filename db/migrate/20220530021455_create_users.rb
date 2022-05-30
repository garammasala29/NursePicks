class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :icon_url
      t.string :url
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end
    add_index :users, %i[provider uid], unique: true
  end
end
