# frozen_string_literal: true

class AddUser < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.timestamps

      t.index :login, unique: true
    end
  end
end
