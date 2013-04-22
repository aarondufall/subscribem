module Subscribem
  class Account < ActiveRecord::Base
    attr_accessible :name, :subdomain, :owner_attributes
    validates :subdomain, presence: true, uniqueness: true
		belongs_to :owner, class_name: "Subscribem::User"
		has_many :accounts_users, class_name: "Subscribem::AccountsUser"
		has_many :users, through: :accounts_users
		accepts_nested_attributes_for :owner


		def self.create_with_owner(params={})
			account = new(params)
			if account.save
				account.users << account.owner
			end
			account
		end  

		def create_schema
			Apartment::Database.create(subdomain)
		end
  end
end
