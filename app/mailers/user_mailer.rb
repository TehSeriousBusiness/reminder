class UserMailer < ActionMailer::Base
  default :from => "teh.serious.business@gmx.net"
  
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
end
