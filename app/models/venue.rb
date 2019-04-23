class Venue < ApplicationRecord
  has_many :performances
  data_accessors :name, :area, :map_link, :image
end
