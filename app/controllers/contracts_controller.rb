class ContractsController < ApplicationController
  def create
  	prep = Prep.find_by_id(params[:prep_id])
  	application = PrepApplication.find_by_id(params[:application_id])
  	contract = Contract.new(params[:contract])
  	contract.prep_application_id = application.id
  	
  	if contract.save
  		application.status = "confirm"
      application.save
      prep.status = "open"
  		prep.save
      PrepMailer.invite(application.user, prep).deliver

  		flash[:alert] = "New contract is successfully created."
  		redirect_to "/preppee/scheduled"
  	else
  		redirect_to prep_prep_application_path(params[:prep_id], params[:application_id]), error: "Unable to create contract"
  	end
  end

  def invite
    prep = Prep.find_by_id(params[:prep_id])
    application = prep.prep_applications.create
    prepper = User.find_by_id(params[:prepper_id])
    application.user_id = prepper.id unless prepper.nil?

    contract = Contract.new(params[:contract])
    contract.prep_application_id = application.id
    
    if contract.save
      application.status = "confirm"
      prep.status="open"
      application.save
      prep.save
      PrepMailer.invite(prepper, prep).deliver

      redirect_to "/preppee/scheduled", notice: "New contract is successfully created."
    else
      redirect_to profile_path(prepper.profile.token), error: contract.errors
    end
  end
end