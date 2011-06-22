class Background
	include Singleton
	
	def sendLater(job)
		@job = job
		
		currentTime = Time.now
	
		#call UserMailer.send_mail(@job)
		if( @job.kickOff <= currentTime)
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
			@job.kickOff = currentTime + @job.delay.seconds
			@job.save()
			
			#send later
			puts "Now! Next mail in #{@job.delay} sec!"
			Background.instance.delay({:run_at => @job.delay.from_now}).sendLater(@job)
		else	
			waitingTime = @job.kickOff.to_i - currentTime.to_i
			puts "Send mail in #{waitingTime} sec!"
			Background.instance.delay({:run_at => waitingTime.from_now}).sendLater(@job)
		end
	end
end