module Subscribem
	module TestingSupport
		module AuthenticationHelpers
			include Warden::Test::Helpers
			def self.include(base)
				base.after do
					logout
				end
			end
			def sign_in_as(options = {})
				options.each do |scope, object|
					login_as(object.id, scope: scope)
				end
			end
			# Rspec.configure do |config|
			# 	config.include AuthenticationHelpers, type: :feature
			# 	config.after type: :feature do
			# 		logout
			# 	end
			#end
		end
	end
end