class UserMailer < ActionMailer::Base
  default :from => "max.mustermann@gmx.net"
  
  def send_mail(job)
    @job = job
	
	# add attachments here...
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
	
	#destinations
	emailArray = @job.destinations.split(/;+/)
	emailArray.each do |email|
		mail(:to => email, :subject => @job.subject, :body => @job.content)
	end
  end
end
