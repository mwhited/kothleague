class AddTeamSizeandPointsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :teamsize, :integer
    add_column :events, :points_for_win, :integer
    add_column :events, :points_for_loss, :integer
  end
end
