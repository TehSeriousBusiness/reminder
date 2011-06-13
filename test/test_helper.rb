ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
	def valid_user_attributes(add_attributes={})
	{
		:username => "Jarqueline",
		:password => "Jarqueli42"
		
	}.merge(add_attributes)
	end
	
	def valid_job_template_attributes(add_attributes={})
	{
		:templateName => "MyTemplateName",
		:templateSubject => "Unknown subject",
		:templateContent => "Unknown content"
		
	}.merge(add_attributes)
	end
	
	def valid_job_attributes(add_attributes={})
	{
		:sender => "senderAddress@host.com",
		:destinations => "dest1@host1.de;dest2@host2.com;dest3@host3.org",
		:subject => "This is a Subject",
		:content => "This is a very long Text, This is also the Content of the Email",
		:kickOff => Time.now,
		:repetition => 4,
		:delay => 60
		
	}.merge(add_attributes)
	end
	
	def valid_mail_server_attributes(add_attributes={})
	{
		:address => "aSimpleAddress@web.de",
		:password => "aSimplePassword",
		:host => "smtp.web.de",
		:port => 23
		
	}.merge(add_attributes)
	end
end
