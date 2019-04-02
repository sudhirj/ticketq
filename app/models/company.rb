class Company < ApplicationRecord
  has_many :shows

  data_accessors :name




end
