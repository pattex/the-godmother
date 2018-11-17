class ApplicationController < ActionController::Base
  force_ssl if: Proc.new { Rails.env.production? }

	private

	def current_person
		@current_person ||= Person.find(session[:person_id]) if session[:person_id]
	end
	helper_method :current_person

	def godmother?
	  if current_person && current_person.role_name == :godmother
      true
    else
      false
    end
  end
  helper_method :godmother?
end
