class CreateStudents < ActiveRecord::Migration
  def change
  	create_table :students do |t|
  		t.string :first_name
  		t.string :last_name
  		t.decimal :gpa, {precision: 8, scale: 2}
  		t.integer :detention_count, default: 0
      t.integer :grade_level
      t.string :gender
      t.string :student_id
  		t.string :misc, default: ""
  		t.references :user, default: nil
      t.timestamps
  	end
  end
end
