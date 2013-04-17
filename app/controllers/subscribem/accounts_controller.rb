require_dependency "subscribem/application_controller"

module Subscribem
  class AccountsController < ApplicationController
  	def new
  		@account = Subscribem::Account.new
  	end

  	def create
  		account = Account.create(params[:account])
  		flash[:success] = "Your account has been successfully created."
  		redirect_to subscribem.root_url
  	end
  end
end
