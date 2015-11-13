require "ar/version"

require "ar/exceptions/record_invalid"

require "ar/data_mappers/base"
require "ar/data_mappers/resource_mapper"

require "ar/entities/resource"
require "ar/entities/action"
require "ar/entities/role"
require "ar/entities/profile"

require "ar/validators/resource_validator"
require "ar/validators/action_validator"
require "ar/validators/role_validator"
require "ar/validators/profile_validator"

require "ar/repositories/registrator"
require "ar/repositories/resources/repository_resource"
require "ar/repositories/resources/finder"
require "ar/repositories/resources/remover"
require "ar/repositories/resources/creator"
require "ar/repositories/actions/repository_action"
require "ar/repositories/actions/creator"

require "ar/services/base"
require "ar/services/actions/create/action_creator"
require "ar/services/resources/create/resource_creator"
require "ar/services/resources/remove/resource_remover"
require "ar/services/resources/resource_manager_creator"

module Ar
  I18n.config.enforce_available_locales = true
  I18n.load_path << File.expand_path('../config/locales/ar.en.yml', __FILE__)
  I18n.reload!
end
