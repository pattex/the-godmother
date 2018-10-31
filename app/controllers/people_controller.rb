class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new

    if ['mentee', 'mentor'].include?(params[:r])
      @person.role_name = params[:r]
    else
      @person.role_name = :mentee
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    unless [1, 2].include?(@person.role)
      @person.role = 1
    end

    if @person.save
      PersonMailer.with(person: @person).verification_email.deliver_now
      redirect_to @person, notice: "You are successfully registered. We sent you a verification mail to your address <#{@person.email}>. You may have to take a look in your junk folder."
    else
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  def verify_email
    @person = Person.find_by(verification_token: params[:verification_token])

    if @person
      if (Person::STATES.values - [:unverified]).include?(@person.state_name)
        msg = { notice: "Your e-mail address is already verified." }
      elsif @person.state_name == :unverified
        @person.state_name = :verified

        if @person.save
          PersonMailer.with(person: @person).new_person_email.deliver_now

          msg = { notice: "Your e-mail address was successfuly verified.\nYour request will now be forwarded to us (the Chaospatinnen orga team) and we will send you an answer as soon as possible… wich can be a while, sorry for that. ^__^" }
        else
          msg = { alert: "Something went wrong. You may want to contact us." }
        end
      else
        msg = { alert: "What are you trying here?!" }
      end
    else
      msg = { alert: "Seems like your verification link is broken. Try copy and paste it by hand." }
    end

    redirect_to home_path, msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find_by(random_id: params[:random_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:role, :random_id, :verification_token, :name, :pronoun, :email, :about)
    end
end
