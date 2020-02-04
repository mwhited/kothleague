class RemoveSbbFromPlayer < ActiveRecord::Migration[6.0]
  def change

    remove_column :players, :sbbskill, :decimal
    remove_column :players, :sbbdeviation, :decimal
    remove_column :rank_histories, :sbbskill, :decimal
    remove_column :rank_histories, :sbbdeviation, :decimal
  end
end
