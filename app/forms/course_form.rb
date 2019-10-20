class CourseForm < ApplicationForm
  property :name
  property :description
  property :fee
  property :is_shot
  property :has_stopped

  copy_validations_from Course
end
