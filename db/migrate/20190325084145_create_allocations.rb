class CreateAllocations < ActiveRecord::Migration[6.0]
  def change
    create_table :allocations, id: :uuid do |t|
      t.string :name, null: false
      t.integer :denom, null: false, default: 0
      t.integer :count, null: false, default: 0
      t.timestamps
    end
  end
end
