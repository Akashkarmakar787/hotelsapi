# frozen_string_literal: true

class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :hotel_name
      t.integer :hotel_rating
      t.string :hotel_address
    end
  end
end
