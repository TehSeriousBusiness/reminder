class JobTemplate < ActiveRecord::Base
  # Urgently needed!
  validates_presence_of :templateName
  validates_presence_of :templateSubject
  validates_presence_of :templateContent
  
  # TemplateName is one of a kind.
  validates_uniqueness_of :templateName
  
  # Every member variable got a maximum length of characters.
  validates_length_of :templateName,    :maximum =>  40
  validates_length_of :templateSubject, :maximum =>  40
  validates_length_of :templateContent, :maximum => 250
 
end
