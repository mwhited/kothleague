class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.string :name
      t.datetime :datetime
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
