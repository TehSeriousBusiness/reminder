require 'yaml'

class Job < ActiveRecord::Base
	belongs_to :user

	# Not yet implemented.
	##  t.binary :attachement

	### validate presences
	validates_presence_of(:sender)				# t.string
	validates_presence_of(:destinations)		# t.text
	validates_presence_of(:subject)				# t.string
	validates_presence_of(:content)				# t.text
	validates_presence_of(:kickOff)				# t.datetime
	validates_presence_of(:repetition)			# t.integer
	validates_presence_of(:delay)				# t.integer

	# validate delay = 1++
	validates_numericality_of :delay, :only_integer => true, :greater_than => 0

	# validate repetition = 0++
	validates_numericality_of :repetition, :only_integer => true, :greater_than_or_equal_to => 0

	validates_length_of :subject, :maximum => 254, :too_long => "subject is too long (%d), subject cannot be saved"

	validates_length_of :content, :maximum => 254, :too_long => "content is too long (%d), this cannot be"
  
	validates_date :kickOff,	:on_or_after => Time.now, :on_or_after_message => "time must be in the future",
								:before => 2.years.from_now, :before_message => "please choose an earlier point in time"
						   
	validate :emailVerify
	
	# Regex for one mail address.
	@@regex = /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	def emailVerify
		#load blacklist-file.
		loadBlacklist
		
		# check destinations first (mail verify and blacklist check)
		emailArray = (destinations || "").split(/;+/)
		emailArray.each do |email|
			unless @@regex.match(email) && !blacklisted?(email, "destinations")
				errors[:destinations] << "Invalid mail address!"
			end
		end
		
		# check sender address (blacklist check only)
		unless sender.nil?
			errors[:sender] << "Invalid mail address!" if blacklisted?(sender, "sender")
		end
	end	
	
	def blacklisted?(check, attribute)
		@BLACKLIST_CONFIG[attribute].include? check.downcase
	end
	
	def loadBlacklist
		@BLACKLIST_CONFIG = YAML::load( File.open( "#{Rails.root}/config/blacklists/job.yml" ) ) if @ONCE.nil?
	end
end