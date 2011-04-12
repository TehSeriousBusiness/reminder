# ATTENTION!
# Validation Notes:
# presence of attachment is not validated! (reason: attachment is optional)

# TODO add a validation to check if the initiator exists (this means: username exists within the DB) - should this reallyy be validated within the job model?
class Job < ActiveRecord::Base
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

  ### validate length
  validates_length_of(:initiator, {:maximum=>254, :too_long=>"username is too long (%d), this cannot be"})
  validates_length_of(:subject, {:maximum=>254, :too_long=>"subject is too long (%d), subject cannot be saved"})

  # email check from http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000084
  # TODO change regex to allow more than one email like (emails are seperated by ";"
  # like: email1@host1.de;email2@host2.com
  validates_format_of :destinations, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  # this second form comes from http://my.rails-royce.org/2010/07/21/email-validation-in-ruby-on-rails-without-regexp/
  validates :destinations, :email => true

  # repetition restriction 1-maxint  -> greater_than => 0
  validates_numericality_of(:repetition, {:greater_than => 0, only_integer => true, :message => "use a integer between 1-maxint"})

  # delay restriction 0-maxint  -> greater_than => -1
  validates_numericality_of(:delay, {:greater_than => -1, only_integer => true, :message => "use a integer between 0-maxint"})
    
  # kickOff restriction, must be in the future
  # TODO
    
end
