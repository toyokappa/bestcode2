class ResumeForm < ApplicationForm
  property :description
  property :start_year
  property :start_month
  property :end_year
  property :end_month

  copy_validations_from Resume
end
