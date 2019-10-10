module NestedChildPopulator
  extend ActiveSupport::Concern

  def nested_child_populator(fragment:, collection:, as:, **)
    child = collection.find_by(id: fragment[:id])
    child || collection.append(as.classify.constantize.new)
  end
end
