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
require "ar/repositories/resources/resource_repository"
require "ar/repositories/resources/creator"

module Ar
  I18n.config.enforce_available_locales = true
  I18n.load_path << File.expand_path('../config/locales/ar.en.yml', __FILE__)
  I18n.reload!
end
