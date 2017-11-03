class CreateTimeCards < ActiveRecord::Migration[5.1]
  def change
    create_table :time_cards do |t|
      t.integer :year, limit: 2
      t.integer :month, limit: 1
      t.integer :day, limit: 1
      t.time :in
      t.time :out

      t.timestamps
    end

    add_index :time_cards, [:user_id, :year, :month, :day], unique: true
  end
end
