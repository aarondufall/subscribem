require_dependency "subscribem/application_controller"

module Subscribem
  class AccountsController < ApplicationController
  	def new
  		@account = Subscribem::Account.new
  		@account.build_owner
  	end

  	def create
  		account = Account.create(params[:account])
  		env['warden'].set_user(account.owner.id, scope: :user)
  		env['warden'].set_user(account.id, scope: :account)
  		flash[:success] = "Your account has been successfully created."
  		redirect_to subscribem.root_url
  	end
  end
end
