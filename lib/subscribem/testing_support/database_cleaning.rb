require'database_cleaner'
module Subscribem
	module TestingSupport
		module DatabaseCleaning
			def self.included(config)
				config.before(:suite) do
			    DatabaseCleaner.strategy = :truncation
			    DatabaseCleaner.clean_with(:truncation)
			  end

			  config.before(:each) do
			    DatabaseCleaner.start
			  end

			  config.after(:each) do
			    Apartment::Database.reset
			    Subscribem::Account.all.each do |account|
			        ActiveRecord::Base.connection.execute("DROP SCHEMA #{account.subdomain} CASCADE;")
			    end
			    DatabaseCleaner.clean
			  end
			end
		end
	end
end