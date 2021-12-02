# frozen_string_literal: true

class AddVerifySslToServer < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :api_verify_ssl, :boolean, default: false
  end
end
