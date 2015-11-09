module Ar
  module DataMappers
    class ResourceMapper < Base
      attributes_to_map :id, :name
    end
  end
end
