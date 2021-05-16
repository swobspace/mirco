class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers do |t|
      t.string :name, null: false, default: ""
      t.string :uid, default: ""
      t.string :location, default: ""
      t.text :description
      t.string :api_url, default: ""
      t.string :api_user, default: ""
      t.text :api_password_ciphertext
      t.boolean :api_user_has_full_access, default: true
      t.jsonb :properties

      t.timestamps
    end
    add_index :servers, :uid
  end
end
