class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.jsonb :data, null: false, default: {}
      t.jsonb :rp_data, null: false, default: {}
      t.references :denomination, null: false, type: :uuid, foreign_key: true
      t.integer :count, null: false
      t.boolean :confirmed, null: false, default: false
      t.timestamps
    end
  end
end
