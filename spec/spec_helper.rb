require 'active_record'
require 'ar'
require 'database_cleaner'
require 'factory_girl'
require 'support/repositories/test_repository'

ActiveRecord::Base.establish_connection(adapter:  'sqlite3',
                                        database: "#{File.dirname(__FILE__)}/ar.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'

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
