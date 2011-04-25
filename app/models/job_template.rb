class JobTemplate < ActiveRecord::Base
  
  # Adding templateName to the attr_accessor list cause failure.
  attr_accessor :templateSubject, :templateContent
  
  # Urgently needed!
  validates_presence_of :templateName
  
  # TemplateName is one of a kind.
  validates_uniqueness_of :templateName
  
  # Every member variable got a maximum length of characters.
  validates_length_of :templateName,    :maximum =>  40
  validates_length_of :templateSubject, :maximum =>  40
  validates_length_of :templateContent, :maximum => 250
 
end
