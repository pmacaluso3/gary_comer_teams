class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password_digest
  		t.boolean :admin, default: false
  		t.string :code
  	end
  end
end
