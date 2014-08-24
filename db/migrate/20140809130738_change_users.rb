class ChangeUsers < ActiveRecord::Migration
  def up
  	change_table :users do |t|
	  	t.string :status
	  	t.string :facebook_url
	  	t.string :vk_url
	  	t.string :phone
	  	t.integer :uid
	  	t.string :provider
	  	t.string :gender
	  	t.integer :city_id
	end
  end

  def down
  	change_table :users do |t|
	  	t.remove :status
	  	t.remove :facebook_url
	  	t.remove :vk_url
	  	t.remove :phone
	  	t.remove :uid	  
	  	t.remove :provider	
	  	t.remove :gender
	  	t.remove :city_id
	end
  end
end
