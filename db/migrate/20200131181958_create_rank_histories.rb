class CreateRankHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :rank_histories do |t|
      t.references :player, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.decimal :sbbskill
      t.decimal :sbbdeviation
      t.decimal :tskill
      t.decimal :tdeviation
      t.integer :points

      t.timestamps
    end
  end
end
