class PreppeeController < ApplicationController
	before_filter :authenticate_user!, :validate_preppee, :scheduled_contracts

	def open_request
		@preps = current_user.preps.where(status: "open")
		if @preps.size == 0
			flash[:alert] = "There is no Open preps"
		else
			flash[:alert] = nil
		end
	end

	def scheduled
		@preps = current_user.preps.where(status: "scheduled")
		if @preps.size == 0
			flash[:alert] = "There is no Scheduled preps"
		else
			flash[:alert] = nil
		end
	end

	private

	def validate_preppee
		if current_user.roles.first.name != "preppee"
			redirect_to "/422.html"
		end
	end

	def scheduled_contracts
		scheduled_preps = Contract.select("count(due_start_date) as count").group("due_start_date")
		

		return if scheduled_preps.nil?
		# @scheduled_contracts = scheduled_preps.contract.distinct(:due_start_time)
		puts "------------------------------------------"

		puts scheduled_preps.inspect
	end
end