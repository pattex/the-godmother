class PeopleController < ApplicationController
  QUESTIONS = [
		["What is two plus two?", "4"],
		["What is the number before twelve?", "11"],
		["Five times two is what?", "10"],
		["Insert the next number in this sequence: 10, 11, 12, 13, 14, …", "15"],
		["What is five times five?", "25"],
		["Ten divided by two is what?", "5"],
		["What day comes after Monday?", "tuesday"],
		["What is the last month of the year?", "december"],
		["How many minutes are in an hour?", "60"],
		["What is the opposite of down?", "up"],
		["What is the opposite of north?", "south"],
		["What is the opposite of bad?", "good"],
		["What is 4 times four?", "16"],
		["What number comes after 20?", "21"],
		["What month comes before July?", "june"],
		["What is fifteen divided by three?", "5"],
		["What is 14 minus 4?", "10"],
		["What comes next? 'Monday Tuesday Wednesday …'", "thursday"]
  ]

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
		@captcha = new_captcha

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
    @captcha = new_captcha

    unless [1, 2].include?(@person.role)
      @person.role = 1
    end

    if params[:address].downcase != QUESTIONS[params[:number].to_i].last
      flash[:alert] = "Are you sure you are human?"
      render :new
    elsif @person.save
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
        @person.tags.each do |t|
          t.active = true
          t.save
        end

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
      params.require(:person).permit(:tag_list, :role, :random_id, :verification_token, :name, :pronoun, :email, :about)
    end

    def new_captcha
      flash = {}
      captcha = [rand(QUESTIONS.size) + 1]
		  captcha << QUESTIONS[captcha.first].first
      return captcha
    end
end
