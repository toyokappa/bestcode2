module NestedChildPopulator
  extend ActiveSupport::Concern

  def nested_child_populator(fragment:, collection:, as:, **)
    child = collection.find_by(id: fragment[:id].to_i)
    if ::ActiveRecord::Type::Boolean.new.cast(fragment["_destroy"])
      collection.delete(child)
      return skip!
    end
    child || collection.append(as.classify.constantize.new)
  end
end
