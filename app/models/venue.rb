class Venue < ApplicationRecord
  has_many :performances
  data_accessors :name, :area
end
