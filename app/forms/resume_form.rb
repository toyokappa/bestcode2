class ResumeForm < ApplicationForm
  property :description
  property :start_date
  property :end_date

  copy_validations_from Resume
end
