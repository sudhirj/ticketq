class CreateDenominations < ActiveRecord::Migration[6.0]
  def change
    create_table :denominations, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.references :performance, null: false, type: :uuid, foreign_key: true
      t.integer :price, null: false
      t.timestamps
    end
  end
end
