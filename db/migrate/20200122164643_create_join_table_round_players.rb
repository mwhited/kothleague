class CreateJoinTableRoundPlayers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :rounds, :players do |t|
      # t.index [:round_id, :player_id]
      # t.index [:player_id, :round_id]
    end
  end
end
