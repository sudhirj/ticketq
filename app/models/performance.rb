class Performance < ApplicationRecord
  belongs_to :show

  has_many :denominations
end
