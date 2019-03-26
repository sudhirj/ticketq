class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.string :mobile, null: false
      t.jsonb :rp_data, null: false, default: {}
      t.boolean :complete, null: false, default: false
      t.timestamps
    end
  end
end
