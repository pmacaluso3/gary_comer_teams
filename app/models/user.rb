class User < ActiveRecord::Base
	has_many :students

	has_secure_password

	validates :email, {presence: true, uniqueness:true}

	def name
		"#{self.first_name} #{self.last_name}"
	end
end