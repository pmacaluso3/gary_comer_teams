class CreateSecrets < ActiveRecord::Migration
	def change
		create_table :secrets do |t|
			t.string :name
			t.string :content
		end
	end
end