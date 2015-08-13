class User < ActiveRecord::Base
	has_many :students

	has_secure_password

	validates :email, {presence: true, uniqueness:true}
	# validates :password, {presence: true}

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
end