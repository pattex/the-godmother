class PersonMailer < ApplicationMailer
  default from: "chaospatinnen@kleinerdrei.net"

  def verification_email
    @person = params[:person]

    options = {
      to: @person.email,
      reply_to: "chaosmentors@lists.ccc.de",
      subject: 'Chaospatinnen - E-Mail Verification'
    }

    mail(options)
  end

  def new_person_email
    @person = params[:person]

    options = {
#      to: "chaosmentors@lists.ccc.de",
      to: "arne@kleinerdrei.net",
      reply_to: @person.email,
      subject: "New #{@person.role_name.to_s.humanize} #{@person.name} [#{@person.random_id}]"
    }

    mail(options)
  end
end
