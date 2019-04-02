class Performance < ApplicationRecord
  belongs_to :show
  belongs_to :venue

  has_many :denominations
end
