# frozen_string_literal: true

# Creates Merchant to associate all connected links
class Merchant < ApplicationRecord
  belongs_to :user
  has_many :links
  has_many :categories, through: :links

  accepts_nested_attributes_for :links, :categories

  validates :name, presence: true
  validates :location, presence: true

  scope :count_stars, -> { maximum(:star_count) }

  def self.by_location(location)
    where(location: location)
  end

  def self.current_favorite(stars)
    where(star_count: stars).order(:created_at)
  end
end
