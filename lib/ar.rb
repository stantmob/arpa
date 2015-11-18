require "ar/version"

# Exceptions
require "ar/exceptions/record_invalid"

# Mappers
require "ar/data_mappers/base"
require "ar/data_mappers/resource_mapper"
require "ar/data_mappers/action_mapper"
require "ar/data_mappers/role_mapper"
require "ar/data_mappers/profile_mapper"

# Entities
require "ar/entities/resource"
require "ar/entities/action"
require "ar/entities/role"
require "ar/entities/profile"

# Validators
require "ar/validators/resource_validator"
require "ar/validators/action_validator"
require "ar/validators/role_validator"
require "ar/validators/profile_validator"

# Repositories
require "ar/repositories/base"
require "ar/repositories/registrator"

require "ar/repositories/resources/repository_resource"
require "ar/repositories/resources/finder"
require "ar/repositories/resources/remover"
require "ar/repositories/resources/creator"

require "ar/repositories/actions/repository_action"
require "ar/repositories/actions/finder"
require "ar/repositories/actions/remover"
require "ar/repositories/actions/creator"

require "ar/repositories/roles/repository_role"
require "ar/repositories/roles/finder"
require "ar/repositories/roles/creator"
require "ar/repositories/roles/updater"

require "ar/repositories/profiles/repository_profile"
require "ar/repositories/profiles/finder"
require "ar/repositories/profiles/creator"
require "ar/repositories/profiles/updater"

# Services
require "ar/services/base"

require "ar/services/actions/create/action_creator"
require "ar/services/actions/remove/action_remover"

require "ar/services/resources/create/resource_creator"
require "ar/services/resources/remove/resource_remover"
require "ar/services/resources/resource_manager_creator"

require "ar/services/roles/role_manager_creator"
require "ar/services/roles/role_manager_updater"
require "ar/services/roles/create/role_creator"
require "ar/services/roles/update/role_updater"

require "ar/services/profiles/profile_manager_creator"
require "ar/services/profiles/profile_manager_updater"
require "ar/services/profiles/create/profile_creator"
require "ar/services/profiles/update/profile_updater"

module Ar
  I18n.config.enforce_available_locales = true
  I18n.load_path << File.expand_path('../config/locales/ar.en.yml', __FILE__)
  I18n.reload!
end
