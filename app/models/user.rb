class User < ActiveRecord::Base
  # has_many :jobs

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
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(username, password)
    find_by_username_and_password(username, password)
  end
end
