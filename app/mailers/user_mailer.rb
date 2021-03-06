class UserMailer < ActionMailer::Base
	default	:return_path => 'teh.serious.business@gmx.net'
  
  def send_mail(job)
    @job = job
	
	# add attachments here...
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	
	#send to each recipient.
	emailArray = @job.destinations.split(/;+/)
	emailArray.each do |email|
		mail(:from => @job.sender, :to => email, :subject => @job.subject).deliver
	end
  end
  
  # setup
  def self.delivering_email(message)
    # message.subject = "#{message.to} #{message.subject}"
    # message.to = "teh.serious.business@gmx.net"
  end
  
  # teardown
  def self.delivered_email(message)
    # do something...
  end
end
