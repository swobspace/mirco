class CreateServerConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :server_configurations do |t|
      t.belongs_to :server, null: false, foreign_key: true
      t.string :comment, default: ""

      t.timestamps
    end
  end
end
