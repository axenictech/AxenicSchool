# EmployeeDepartment model
class EmployeeDepartment < ActiveRecord::Base
  has_many :employees
  validates :name, presence: true, length: \
  { minimum: 1, maximum: 30 }, length: { minimum: 1, maximum: 30 }, format: \
  { with: /\A[a-z A-Z]+\z/, message: 'only allows letters' }

  validates :code, presence: true,
                   length: { minimum: 1, maximum: 10 }
  scope :is_status, -> { where(status: true).order(:name) }
  scope :not_status, -> { where(status: false).order(:name) }
  def assign_employee(batch)
    emp = []
    employees = self.employees.pluck(:id)
    employees.each { |e| emp << e.to_s }
    if batch.employee_id
      assign_employees = batch.employee_id.split(',')
      emp - assign_employees
    else
      emp
    end
  end
end
