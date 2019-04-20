class Company < ApplicationRecord
  has_many :shows

  data_accessors :name, :rp_account, :logo




end
