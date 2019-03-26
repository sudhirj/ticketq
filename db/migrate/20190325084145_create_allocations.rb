class CreateAllocations < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    create_table :allocations, id: :uuid do |t|
      t.integer :denom, null: false, default: 0
      t.integer :count, null: false, default: 0
      t.timestamps
    end
  end
end
