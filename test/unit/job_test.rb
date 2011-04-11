require 'test_helper'

class JobTest < ActiveSupport::TestCase

  #### Missing Parameters START ####
  ### Checking for missing parameters
  ##  t.string :initiator
  ##  t.text :destinations
  ##  t.string :subject
  ##  t.text :content
  ##  t.binary :attachement
  ##  t.date :kickOff
  ##  t.integer :repetition
  ##  t.integer :delay
  ### init predefined parameters to use in all "missing paramteres tests"
  testVarInitiator = "myUserName"
  testVarDestinations = "dest1@host1.de;dest2@host2.com;dest3@host3.org"
  testVarSubject = "This is a Subject"
  testVarContent = "This is a very long Text, This is also the Content of the Email"
  testVarAttachment = "asdfasf" # iam a binary TODO CHANGE ME!
  testVarKickOff = "myUserName"
  testVarDelay = "myUserName"
  
  test "Missing Parameters - initiator" do
    # No initiator is set
    job = Job.new(:username => "Jarqueline")
    assert !(job.save()), 'password required'
  end
  #### Missing Parameters END ####
  
  
  #### XYZ START ####
  
  #### XYZ END ####
  
end
