class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  smtp_settings = {
    :address              => "smtp.ccchb.de",
    :port                 => 587,
    :domain               => "ccchb.de",
    :user_name            => "chaosmentors@ccchb.de",
    :password             => "g3Y763BDgVQxOmrV2H5g",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
end
