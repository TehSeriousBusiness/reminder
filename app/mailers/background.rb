class Background
	include Singleton

	def sendLater(job)
		@job = job
	
		#call UserMailer.send_mail(@job)
		if( @job.kickOff <= Time.now)
			UserMailer.send_mail(@job)
			# check, repetition < 0 should also be needless.
			if (@job.repetition == 1)
				@job.destroy
				return;
			elsif (@job.repetition != 0)
				@job.repetition -= 1
			end
			@job.kickOff = Time.now.utc + @job.delay.seconds #may cause problem : job_delay vs member var
			@job.save()
		end
		
		#send later
		b = Background.instance
		b.delay({:run_at => @job.delay.from_now}).sendLater(@job)
	end
	
	def destroyAll
		Job.all.each do |job|
			job.destroy
		end
	end
end