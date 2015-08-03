class Students < ActiveRecord::Migration
  def change
  	create_table :students do |t|
  		t.string :first_name
  		t.string :last_name
  		t.decimal :gpa, {precision: 8, scale: 2}
  		t.integer :detentions
  		t.string :misc
  		t.references :user
  	end
  end
end
