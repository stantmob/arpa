module Ar
  module DataMappers
    class ResourceMapper < Base
      attributes_to_map :id, :name, :full_name, :actions
    end
  end
end
