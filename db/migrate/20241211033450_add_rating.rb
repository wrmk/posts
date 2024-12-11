# frozen_string_literal: true

class AddRating < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.integer :value, null: false
      t.references :user, null: false, foreign_key: true, index: false
      t.references :post, null: false, foreign_key: true, index: false
      t.timestamps

      t.index %i[user_id post_id], unique: true
    end
  end
end
