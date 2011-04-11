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
  testVarAttachment = 0b111111110000000000000011 # iam a binary -> hex: F03
  testVarKickOff = Time.now()
  testVarRepetition = 4
  testVarDelay = 60 # delay is 60 seconds
  ## default without missing parameters
  #job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)

  test "Missing Parameters - initiator" do
    job = Job.new(:destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert !(job.save()), 'initiator required'
  end
  
  test "Missing Parameters - destinations" do
      job = Job.new(:initiator => testVarInitiator, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
      assert !(job.save()), 'destinations required'
    end
    
  test "Missing Parameters - subject" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
      assert !(job.save()), 'subject required'
    end
    
  test "Missing Parameters - content" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
      assert !(job.save()), 'content required'
    end
    
  test "Missing Parameters - attachement" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
      assert !(job.save()), 'attachement required'
    end
    
  test "Missing Parameters - kickOff" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :repetition => testVarRepetition, :delay => testVarDelay)
      assert !(job.save()), 'kickOff required'
    end
    
  test "Missing Parameters - repetition" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :delay => testVarDelay)
      assert !(job.save()), 'repetition required'
    end
    
  test "Missing Parameters - delay" do
      job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition)
      assert !(job.save()), 'delay required'
    end
  #### Missing Parameters END ####

  #### XYZ START ####

  #### XYZ END ####

end
