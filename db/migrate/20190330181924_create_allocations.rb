class CreateAllocations < ActiveRecord::Migration[6.0]
  def change
    create_table :allocations do |t|
      t.jsonb :data, null: false, default: {}
      t.references :denomination, null: false, type: :uuid, foreign_key: true
      t.integer :count, null: false, default: 0
      t.timestamps
    end
  end
end
