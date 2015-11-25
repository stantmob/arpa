require 'active_record'
require 'arpa'
require 'database_cleaner'
require 'factory_girl'
require 'support/repositories/test_repository'
require 'i18n'

ActiveRecord::Base.establish_connection(adapter:  'sqlite3',
                                        database: "#{File.dirname(__FILE__)}/arpa.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'

I18n.config.enforce_available_locales = true
I18n.load_path << File.expand_path('../../lib/config/locales/arpa.en.yml', __FILE__)
I18n.reload!

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
