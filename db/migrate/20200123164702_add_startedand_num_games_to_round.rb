class AddStartedandNumGamesToRound < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :started, :boolean, :default => false
    add_column :rounds, :numgames, :integer, :default => 0
  end
end
