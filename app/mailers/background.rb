class Background
	include Singleton
	
	def sendLater(job)
		@job = job
	
		#call UserMailer.send_mail(@job)
		if( @job.kickOff.utc <= Time.now.utc)
			begin
				UserMailer.send_mail(@job)
			rescue Exception => e
				puts e
				@job.destroy
				return;
			end
			
			# check, repetition < 0 should also be needless.
			if (@job.repetition == 1)
				@job.destroy
				return;
			elsif (@job.repetition != 0)
				@job.repetition -= 1
			end
			@job.kickOff = Time.now.utc + @job.delay.seconds
			@job.save()
		end
		
		#send later
		Background.instance.delay({:run_at => @job.delay.from_now}).sendLater(@job)
	end
end