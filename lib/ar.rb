require "ar/version"

# Exceptions
require "ar/exceptions/record_invalid"

# Mappers
require "ar/data_mappers/base"
require "ar/data_mappers/resource_mapper"
require "ar/data_mappers/action_mapper"

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
require "ar/repositories/actions/remover"
require "ar/repositories/actions/creator"

# Services
require "ar/services/base"

require "ar/services/actions/create/action_creator"
require "ar/services/actions/remove/action_remover"

require "ar/services/resources/create/resource_creator"
require "ar/services/resources/remove/resource_remover"
require "ar/services/resources/resource_manager_creator"

module Ar
  I18n.config.enforce_available_locales = true
  I18n.load_path << File.expand_path('../config/locales/ar.en.yml', __FILE__)
  I18n.reload!
end
