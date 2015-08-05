require 'csv'

class StudentsController < ApplicationController
	def new
		admin? do

		end
	end

	def index
		puts "************************ /students/index got visited"
		logged_in? do
			@students = Student.all
		end
		admin? do
			@admin = true
		end
	end

	def show
		logged_in? do
			@student = Student.find_by(id: params[:id])
		end
	end

	def unassign
		admin? do
			s = Student.find_by(id: params[:student_id])
			s.advisor = nil
			s.save
			@students = Student.all
			render "students/index"
		end
	end

	def assign
		logged_in? do
			user = User.find_by(id: session[:user_id])
			student = Student.find_by(id: params[:student_id])
			student.advisor = user.last_name
			student.save
			@students = Student.all
			render "students/index"
		end
	end

	def create
		admin? do
			split_student_lines = []

			student_lines = student_data.split(/[\r\n]+/)
			student_lines.each do |l|
				split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
			end

			headers = split_student_lines[0]
			split_student_lines = split_student_lines[1..-1]

			student_hashes = []

			split_student_lines.each do |line|
				this_student_hash = {}
				line.each_with_index do |value, i|
					this_student_hash[headers[i].downcase] = value
				end
				student_hashes << this_student_hash
			end


			student_hashes.each do |hash|
				this_student = Student.find_or_create_by(student_id: hash["student_id"])
				misc_hash = this_student.misc_hash

				hash.each do |k, v|
					if this_student.respond_to?("#{k.downcase}=")
						m = this_student.method("#{k.downcase}=")
						m.call(v)
					else
						misc_hash[k] = v
					end
				end

				misc_string = ""
				misc_hash.each do |k, v|
					misc_string += "#{k}:#{v},"
				end

				this_student.misc = misc_string
				this_student.save
			end

			# File.open(filename) do |f|
			# 	student_data = f.read
			# 	student_lines = student_data.split("\n")
			# 	student_lines.each do |l|
			# 		split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
			# 	end
			# end

			# CSV.foreach(filename.path) do |row|
			# 	puts row.inspect
			# end
		redirect_to students_path
		end
	end

	private

	def student_data
		params.require(:students).permit(:students)[:students]
	end

	def filename
		params.require(:students).permit(:students)[:students]
	end
end