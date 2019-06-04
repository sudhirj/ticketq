class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.string :email, null: false
      t.string :code, null: false

      t.timestamps
    end
  end
end
