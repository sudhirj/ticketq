class Show < ApplicationRecord
  belongs_to :company
  has_many :performances
  data_accessors :name, :tagline

end