class Student < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :student_id, {presence:true, uniqueness: true}

	def advisor
		self.user
	end

	def advisor=(new_advisor_last)
		new_advisor = User.find_by(last_name: new_advisor_last)
		self.user = new_advisor
	end

	def last
		self.last_name
	end

	def last=(new_last)
		self.last_name = new_last
	end

	def first
		self.first_name
	end

	def first=(new_first)
		self.first_name = new_first
	end
end