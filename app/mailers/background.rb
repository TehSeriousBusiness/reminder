class Background
	include Singleton

	def sendLater
		Job.all.each do |job|
			puts 'now: ' + Time.now.to_s
			puts 'kickOff: ' + job.kickOff.to_s
			diff = Time.now.to_i - job.kickOff.to_i
			puts "diff: " + diff.to_s
		end
	end
	
	def helloWorld
		4.times {
			puts 'Hello World'
		}
	end
end