# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  validates :user_id, presence: true
  validates :hotel_id, presence: true
  validates :post, presence: true
end
