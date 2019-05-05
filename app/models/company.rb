class Company < ApplicationRecord
  has_many :shows

  store_accessor :data, :name, :rp_account, :logo, :contact_email




end
