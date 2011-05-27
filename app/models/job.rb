# ATTENTION!
# Validation Notes:
# presence of attachment is not validated! (reason: attachment is optional)

# TODO add a validation to check if the initiator exists (this means: username exists within the DB) - should this reallyy be validated within the job model?
class Job < ActiveRecord::Base
  #belongs_to :user

  ##  t.string :initiator
  ##  t.text :destinations
  ##  t.string :subject
  ##  t.text :content
  ##  t.binary :attachement
  ##  t.date :kickOff
  ##  t.integer :repetition
  ##  t.integer :delay

  ### validate presences
  validates_presence_of(:initiator)
  validates_presence_of(:destinations)
  validates_presence_of(:subject)
  validates_presence_of(:content)
  validates_presence_of(:kickOff)

  validates_presence_of(:repetition)
  validates_presence_of(:delay)

  # validate delay = 0++
  validates_numericality_of :delay, :only_integer => true, :greater_than => -1

  # validate repetition = 0++
  validates_numericality_of :repetition, :only_integer => true, :greater_than => -1

  validates_length_of :subject, :maximum => 254, :too_long => "subject is too long (%d), subject cannot be saved"

  validates_length_of :content, :maximum => 254, :too_long => "content is too long (%d), this cannot be"
  #                                              mail      @  host         . topdomain      ;
  #  validates_format_of :destinations, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # validates_format_of :destinations, :with => "(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i;)+"
  #validates_format_of :destinations, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,};)\Z/i
  validate :email => true

  
  def email
    emailArray = :destinations.split(/;+/)
    emailArray.each do |email|
      if(!/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.match(email))
        #        puts "invalid " + email
        record.errors[attribute] << "destination " + email + " is wrong"
      end
    end
  end
end