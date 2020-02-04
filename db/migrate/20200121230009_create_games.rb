class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :team1, null: false, foreign_key: { to_table: 'teams' }
      t.references :team2, null: false, foreign_key: { to_table: 'teams' }
      t.integer :t1score
      t.integer :t2score
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
