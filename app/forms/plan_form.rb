class PlanForm < Reform::Form
  property :name, validates: { presence: true }
  property :description
  property :state

  collection :courses do
    property :name, validates: { presence: true }
    property :description
    property :fee
    property :is_shot
    property :has_stopped
  end
end
