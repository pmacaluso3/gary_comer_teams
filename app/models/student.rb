class Student < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :student_id, {presence:true, uniqueness: true}

	def advisor
		if self.user
			self.user.last_name
		else
			false
		end
	end

	def advisor=(new_advisor_last)
		self.user =  User.find_by(last_name: new_advisor_last)
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

	def name
		"#{self.first_name} #{self.last_name}"
	end

	def misc_hash
		out = {}
		misc_properties = self.misc.split(",")
		misc_properties.each do |prop|
			pair = prop.split(":")
			out[pair[0]] = pair[1]
		end
		out
	end
end