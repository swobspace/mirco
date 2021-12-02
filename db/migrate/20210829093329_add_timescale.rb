class AddTimescale < ActiveRecord::Migration[6.1]
  def change
    enable_extension('timescaledb') unless extension_enabled? 'timescaledb'
  end
end
