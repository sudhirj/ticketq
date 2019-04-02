# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    create_table :companies, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.string :slug, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
