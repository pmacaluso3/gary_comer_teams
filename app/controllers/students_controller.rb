class StudentsController < ApplicationController
	def new
		admin? do

		end
	end

	def create
		split_student_lines = []
		File.open(filename) do |f|
			student_data = f.read
			student_lines = student_data.split("\n")
			student_lines.each do |l|
				split_student_lines << l.split(/[,+\ +]/).reject{|e|e==""}
			end
		end

		p "*************************** #{split_student_lines}"

		render "students/index"
	end

	private
	def filename
		params.require(:students).permit(:students)[:students]
	end
end