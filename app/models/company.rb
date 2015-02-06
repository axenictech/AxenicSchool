# company
class Company < ActiveRecord::Base
  include Activity
  validates :name, presence: true, length: { \
    minimum: 1, maximum: 20 }, format: { with: /\A[a-zA-Z0-9" "-]+\Z/ }
  validates :criteria, presence: true, length: { minimum: 1, maximum: 9000 }

  def self.conduct_exam(company)
    questions = []
    @questions = []
    exam = PlacementExam.where(company_id: company.id).take
    tot_que = exam.question_count
    exam.weightages.each do |i|
      pr = Weightage.where(question_type_id: i.question_type_id).take.percentage
      quest = (tot_que * pr / 100).floor
      questions << [i.question_type_id, quest.floor]
    end
    questions.each do |q|
      ques = QuestionDatabase.where(question_type_id: q[0]).limit(q[1])
      ques.each do |que|
        @questions << que
      end
    end
    @questions
  end
end
