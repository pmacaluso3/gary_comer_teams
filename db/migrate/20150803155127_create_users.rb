class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :email
  		t.string :first_name
  		t.string :last_name
  		t.string :password_digest
  		t.boolean :admin, default: false
  		t.string :code
  		t.timestamps
  	end
  end
end
