# frozen_string_literal: true

class Hotel < ApplicationRecord
  has_many :comments
  validates :hotel_address, presence: true
  validates :hotel_name, presence: true
end
