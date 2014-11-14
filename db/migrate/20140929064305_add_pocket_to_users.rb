class AddPocketToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pocket, :decimal, :precision => 9, :scale => 2, :default => 0.0
  end
end
