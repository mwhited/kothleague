class AddEventToTeam < ActiveRecord::Migration[6.0]
  def change
    add_reference :teams, :event, null: false, foreign_key: true
  end
end
