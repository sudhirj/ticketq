class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.jsonb :rp_data, null: false, default: {}
      t.references :denomination, null: false, type: :uuid, foreign_key: true
      t.integer :count, null: false
      t.boolean :confirmed, null: false, default: false
      t.boolean :active, null: false, default: true
      t.string :receipt, index: { unique: false }
      t.boolean :email_sent, null: false, default: false
      t.boolean :sms_sent, null: false, default: false
      t.timestamps
    end
  end
end
