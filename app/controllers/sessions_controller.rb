class SessionsController < ApplicationController
  def new
  end

  def create
    person = Person.find_by_email(params[:email])
	  if person && person.authenticate(params[:password])
			session[:person_id] = person.id

      redirect_url = session[:last] ? session[:last] : root_url

			redirect_to redirect_url, :notice => "Logged in!"
		else
			flash.now.alert = "Invalid credentials"
			render "new"
		end
  end

  def destroy
    session[:person_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
