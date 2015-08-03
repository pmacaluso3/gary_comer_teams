class Student < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true
	validates :last_name, presence: true
end