class AddHostToInterfaceAndServer < ActiveRecord::Migration[6.1]
  def change
    add_reference :software_interfaces, :host, foreign_key: true
    add_reference :servers, :host, foreign_key: true
  end
end
