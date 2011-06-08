# ATTENTION!
# Validation Notes:
# presence of attachment is not validated! (reason: attachment is optional)
class Job < ActiveRecord::Base
	belongs_to :user

	##  t.string :sender
	##  t.text :destinations
	##  t.string :subject
	##  t.text :content
	##  t.binary :attachement
	##  t.date :kickOff
	##  t.integer :repetition
	##  t.integer :delay

	### validate presences
	validates_presence_of(:sender)
	validates_presence_of(:destinations)
	validates_presence_of(:subject)
	validates_presence_of(:content)
	validates_presence_of(:kickOff)

	validates_presence_of(:repetition)
	validates_presence_of(:delay)

	# validate delay = 0++
	validates_numericality_of :delay, :only_integer => true, :greater_than_or_equal_to => 0

	# validate repetition = 0++
	validates_numericality_of :repetition, :only_integer => true, :greater_than_or_equal_to => 0

	validates_length_of :subject, :maximum => 254, :too_long => "subject is too long (%d), subject cannot be saved"

	validates_length_of :content, :maximum => 254, :too_long => "content is too long (%d), this cannot be"
  	
	# Tested with http://www.rubular.com/, validates multiple email-addresses
	validates_format_of :destinations, :with => /\A(([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,});+)*(([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,});*\z)/i
	#validates_format_of :sender, :with => @@regex, ideal: Firstname Secondname <mailaddress>
  
	validates_date :kickOff,	:on_or_after => Time.now, :on_or_after_message => "time must be in the future",
								:before => 2.years.from_now, :before_message => "please choose an earlier point in time"
						   
	  
	# validate :emailVerify => true
	
	# Regex for one mail address.
	@@regex = /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	# def emailVerify
		# emailArray = @destinations.split(/;+/)
		# result = false
		
		# emailArray.each do |email|
			# if(@@regex.match(email))
				# result = true
			# else
				# return false
			# end
		# end
		# result
	# end	
end