class PersonMailer < ApplicationMailer
  default from: "chaospatinnen@kleinerdrei.net"

  def verification_email
    @person = params[:person]

    options = {
      to: @person.email,
      reply_to: Rails.configuration.x.basic.list_address,
      subject: 'Chaospatinnen - E-Mail Verification'
    }

    mail(options)
  end

  def new_person_email
    @person = params[:person]

    options = {
      to: Rails.configuration.x.basic.list_address,
      reply_to: @person.email,
      subject: "New #{@person.role_name.to_s.humanize} #{@person.name} [#{@person.random_id}]"
    }

    mail(options)
  end
end
