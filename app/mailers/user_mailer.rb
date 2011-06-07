class UserMailer < ActionMailer::Base
	default	:from => "Max Mustermann <max.mustermann@gmx.de>",
			:return_path => 'Max Mustermann <teh.serious.business@gmx.net>'
  
  def send_mail(job)
    @job = job
	
	# add attachments here...
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	
	#send to each recipient.
	emailArray = @job.destinations.split(/;+/)
	emailArray.each do |email|
		mail(:to => email, :subject => @job.subject).deliver
	end
  end
  
  # setup
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "manuel.hager@gmx.de"
  end
  
  # teardown
  def self.delivered_email(message)
    # do something...
  end
end
