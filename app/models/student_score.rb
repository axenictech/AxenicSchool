class StudentScore < ActiveRecord::Base
  belongs_to :placement_exams
  belongs_to :students
end
