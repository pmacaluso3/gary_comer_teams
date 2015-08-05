class Student < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true

	def advisor
		self.user_id
	end

	def advisor=(new_advisor_id)
		self.user_id = new_advisor_id
		self.save
	end
end