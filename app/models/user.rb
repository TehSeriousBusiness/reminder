class User < ActiveRecord::Base
  
  # Urgently needed!
  validates_presence_of :username
  validates_presence_of :password
  
  # Username is one of a kind.
  validates_uniqueness_of :username
  
  # Used regex to validate password and username.
  @@regex =  /^([0-9]|[a-z]|[A-Z]){3,10}$/
  
  # Use regex format to check both member variables.
  validates_format_of :username, :with => @@regex
  validates_format_of :password, :with => @@regex
  
end
