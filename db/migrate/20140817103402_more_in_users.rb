class MoreInUsers < ActiveRecord::Migration
  def up
  	change_table :users do |t|
	  	t.integer :country_id
      t.integer :state_id
	end
  end

  def down
  	change_table :users do |t|
	  	t.remove :country_id
	end
  end
end
