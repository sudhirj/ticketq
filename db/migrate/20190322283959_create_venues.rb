class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.string :slug, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
