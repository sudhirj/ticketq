class Venue < ApplicationRecord
  has_many :performances
  store_accessor :data, :name, :area, :map_link, :image
end
