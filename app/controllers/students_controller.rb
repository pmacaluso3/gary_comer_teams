require 'csv'

class StudentsController < ApplicationController
	def new
		admin? do

		end
	end

	def create
		split_student_lines = []
		# File.open(filename) do |f|
		# 	student_data = f.read
		# 	student_lines = student_data.split("\n")
		# 	student_lines.each do |l|
		# 		split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
		# 	end
		# end

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
				this_student_hash[headers[i]] = value
			end
			student_hashes << this_student_hash
		end

		student_hashes.each do |hash|
			this_student = Student.find_or_create_by(hash[:student_id])
			hash.each do |k, v|
				if this_student.respond_to?(k.downcase)
					m = this_student.method("#{k.downcase}=")
					m.call(v)
				else

				end
			end
			puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{this_student.inspect}, gpa: #{this_student.gpa.to_s}"
		end


		# CSV.foreach(filename.path) do |row|
		# 	puts row.inspect
		# end



		puts "*************************** #{student_lines}"
		puts "*************************** #{split_student_lines}"

		render "students/index"
	end

	private

	def student_data
		params.require(:students).permit(:students)[:students]
	end

	def filename
		params.require(:students).permit(:students)[:students]
	end
end