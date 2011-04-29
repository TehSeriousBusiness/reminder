class MailServer < ActiveRecord::Base
  
  # Urgently needed!
  validates_presence_of :address
  validates_presence_of :password
  validates_presence_of :host
  validates_presence_of :port
  
  # Address is one of a kind.
  validates_uniqueness_of :address
  
  # Every member variable got a maximum length of characters.
  validates_length_of :address,   :maximum =>  40
  validates_length_of :password,  :maximum =>  40
  validates_length_of :host,      :maximum =>  40
  
  # Port - constraint
  validates_numericality_of :port, :only_integer => true, :message => "can only be whole integer number."
  validates_inclusion_of :port, :in => 0..65535, :message => "can only be between 0 and 65535." 
  
end
