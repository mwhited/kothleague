class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.decimal :sbbdeviation
      t.decimal :sbbskill
      t.decimal :tdeviation
      t.decimal :tskill
      t.integer :points
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
