ActionMailer::Base.smtp_settings = {
  :address              => "mail.gmx.net",
  :port                 => 25,
  :domain               => "gmx.net",
  :user_name            => "teh.serious.business@gmx.net",
  :password             => "IHazInternetz",
  :authentication       => "plain",
  :enable_starttls_auto => true
}