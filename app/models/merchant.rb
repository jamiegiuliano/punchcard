class Merchant < ApplicationRecord
  belongs_to :user
  has_one :link

  accepts_nested_attributes_for(:link, update_only: true)

  validates :name, presence: true
  validates :location, presence: true

  def self.by_location(location)
    where(location: location)
  end

  def self.most_stars
    binding.pry
  end
end
