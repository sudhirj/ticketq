# frozen_string_literal: true

class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.references :company, null: false, type: :uuid, foreign_key: true
      t.string :url, null: false
      t.timestamps
    end
    add_index :shows, %i[company_id url], unique: true
  end
end
