# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :server, null: false, foreign_key: true
      t.belongs_to :channel, null: true, foreign_key: false
      t.belongs_to :user, null: false, foreign_key: { to_table: 'wobauth_users' }
      t.string :type, null: false

      t.timestamps
    end
    add_index :notes, :type
  end
end
