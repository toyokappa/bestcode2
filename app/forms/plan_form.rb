class PlanForm < Reform::Form
  property :name, validates: { presence: true }
  property :description
  property :state

  collection :spots do
    property :name, validates: { presence: true }
    property :description
    property :review
    property :position
  end
end
