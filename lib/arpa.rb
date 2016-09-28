require "arpa/version"
require "rails/railtie"

# Additions
require "arpa/additions/resource"

# Exceptions
require "arpa/exceptions/record_invalid"

# Entities
require "arpa/entities/resource"
require "arpa/entities/action"
require "arpa/entities/role"
require "arpa/entities/profile"

# Mappers
require "arpa/data_mappers/base"
require "arpa/data_mappers/resource_mapper"
require "arpa/data_mappers/action_mapper"
require "arpa/data_mappers/role_mapper"
require "arpa/data_mappers/profile_mapper"

# Validators
require "arpa/validators/resource_validator"
require "arpa/validators/action_validator"
require "arpa/validators/role_validator"
require "arpa/validators/profile_validator"

# Repositories
require "arpa/repositories/base"
require "arpa/repositories/registrator"

require "arpa/repositories/resources/repository_resource"
require "arpa/repositories/resources/finder"
require "arpa/repositories/resources/remover"
require "arpa/repositories/resources/creator"

require "arpa/repositories/actions/repository_action"
require "arpa/repositories/actions/finder"
require "arpa/repositories/actions/remover"
require "arpa/repositories/actions/creator"

require "arpa/repositories/roles/repository_role"
require "arpa/repositories/roles/finder"
require "arpa/repositories/roles/creator"
require "arpa/repositories/roles/updater"
require "arpa/repositories/roles/remover"

require "arpa/repositories/profiles/repository_profile"
require "arpa/repositories/profiles/finder"
require "arpa/repositories/profiles/creator"
require "arpa/repositories/profiles/updater"
require "arpa/repositories/profiles/remover"

# Services
require "arpa/services/base"
require "arpa/services/verifier"

require "arpa/services/actions/create/action_creator"
require "arpa/services/actions/remove/action_remover"

require "arpa/services/resources/create/resource_creator"
require "arpa/services/resources/remove/resource_remover"
require "arpa/services/resources/resource_manager_creator"

require "arpa/services/roles/role_manager_creator"
require "arpa/services/roles/role_manager_updater"
require "arpa/services/roles/role_manager_remover"
require "arpa/services/roles/create/role_creator"
require "arpa/services/roles/update/role_updater"
require "arpa/services/roles/remove/role_remover"

require "arpa/services/profiles/profile_manager_creator"
require "arpa/services/profiles/profile_manager_updater"
require "arpa/services/profiles/profile_manager_remover"
require "arpa/services/profiles/create/profile_creator"
require "arpa/services/profiles/update/profile_updater"
require "arpa/services/profiles/remove/profile_remover"

module Arpa

  class Railtie < ::Rails::Railtie
    initializer "arpa.configure_view_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Arpa::Additions::Resource
      end
    end
  end

end
