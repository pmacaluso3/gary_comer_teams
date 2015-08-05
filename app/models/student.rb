class Student < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :student_id, {presence:true, uniqueness: true}

	def advisor
		self.user_id
	end

	def advisor=(new_advisor_id)
		self.user_id = new_advisor_id
		self.save
	end

	def last
		self.last_name
	end

	def last=(new_last)
		self.last_name = new_last
		self.save
	end

	def first
		self.first_name
	end

	def first=(new_first)
		self.first_name = new_first
		self.save
	end
end