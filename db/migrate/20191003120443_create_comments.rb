# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :post
      t.integer :hotel_id
      t.integer :user_id
    end
  end
end
