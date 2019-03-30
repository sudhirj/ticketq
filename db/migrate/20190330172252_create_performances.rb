class CreatePerformances < ActiveRecord::Migration[6.0]
  def change
    create_table :performances, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}
      t.references :show, null: false, type: :uuid, foreign_key: true
      t.datetime :showtime, null: false
      t.timestamps
    end
  end
end
