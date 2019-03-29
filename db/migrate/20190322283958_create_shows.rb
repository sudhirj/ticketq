class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.references :company, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
