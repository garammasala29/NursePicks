class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :icon_url
      t.string :url
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
