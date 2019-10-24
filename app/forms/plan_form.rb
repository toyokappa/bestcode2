class PlanForm < ApplicationForm
  include NestedChildPopulator

  property :name
  property :description
  property :state

  collection :courses, form: CourseForm, populator: :nested_child_populator

  copy_validations_from Plan
end
