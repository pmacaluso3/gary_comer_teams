class User < ActiveRecord::Base
	has_many :students

	has_secure_password

	validates :username, {presence: true, uniqueness:true}
end