class Show < ApplicationRecord
  belongs_to :company

  has_many :performances
end
