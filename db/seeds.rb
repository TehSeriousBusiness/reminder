# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:username => 'Admin', :password => 'wsadmin')
User.create(:username => 'Anon', :password => 'guest')


JobTemplate.create(:templateName => 'Sample#1', :templateSubject => 'HAR HAR HAR', :templateContent => "It's me again! ;-)")


MailServer.create(:address => "teh.serious.business@gmx.net", :password => "IHazInternetz", :host => "mail.gmx.net", :port => 25)


# ActionMailer::Base.smtp_settings = {
  # :domain               => "gmx.net",
  # :authentication       => "plain",
  # :enable_starttls_auto => true
# }