require 'test_helper'

### TODO: validation for parameters missing: content, attachement
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
  @@testVarInitiator = "testUserName"
  @@testVarDestinations = "dest1@host1.de;dest2@host2.com;dest3@host3.org"
  @@testVarSubject = "This is a Subject"
  @@testVarContent = "This is a very long Text, This is also the Content of the Email"
  @@testVarattachement = 0b111111110000000000000011 # iam a binary -> hex: F03
  @@testVarKickOff = Time.now()
  @@testVarRepetition = 4
  @@testVarDelay = 60 # delay is 60 seconds
  ## default without missing parameters
  #job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent,  :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
  def setup
    @validJob = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent,  :kickOff => @@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
  end

  test "Valid - Creating Valid Job  Object" do
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Missing Parameters - initiator" do
    job = Job.new(:destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent, :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - destinations" do
    job = Job.new(:initiator => @@testVarInitiator, :subject => @@testVarSubject, :content => @@testVarContent,  :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - subject" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :content => @@testVarContent,  :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - content" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject,  :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - attachement" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent, :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - kickOff" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent,  :repetition => @@testVarRepetition, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - repetition" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent,  :kickOff =>@@testVarKickOff, :delay => @@testVarDelay)
    assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - delay" do
    job = Job.new(:initiator => @@testVarInitiator, :destinations => @@testVarDestinations, :subject => @@testVarSubject, :content => @@testVarContent,  :kickOff =>@@testVarKickOff, :repetition => @@testVarRepetition)
    assert !job.save(), job.errors.inspect
  end
  #### Missing Parameters END ####

  test "Invalid - Validate Parameter - destinations - invalid destinations 01" do
    @validJob.destinations = "nomail@bla"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 02" do
    @validJob.destinations = "nomail.bla.de@"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 03" do
    @validJob.destinations = "@nomail.bla.de"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 04" do
    @validJob.destinations = "nomail@.de"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 05" do
    @validJob.destinations = "nomail@"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 06" do
    @validJob.destinations = "nomail@."
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - destinations - invalid destinations 07" do
    @validJob.destinations = "@host.de"
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - initiator - valid destinations 01" do
    @validJob.destinations = "mail.mit@punkt.com"
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - initiator - valid destinations 02" do
    @validJob.destinations ="mail_mit@unterstrich.com"
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - initiator - valid destinations 03" do
    @validJob.destinations ="mail-mit@bindestrich.com"
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - subject - subject length > 254" do
    # this parameter is longer than 254 chars
    subject = "";
    # loop 255 times and add a s to the string -> creating a string longer than 254
    for i in 1..255 do
      subject = subject + "s"
    end
    @validJob.subject = subject

    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - subject - subject length <= 254" do

    # this parameter is longer than 254 chars
    subject = "";
    # loop 255 times and add a s to the string -> creating a string longer than 254
    for i in 1..254 do
      subject = subject + "s"
    end
    @validJob.subject = subject

    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - kickOff - time is in the past" do
    @validJob.kickOff = (-2).days().from_now()
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - kickOff - time is in the future" do
    @validJob.kickOff = 2.days().from_now()
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - repetition - number <= 0    -> no sense -1" do
    @validJob.repetition = -1
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - repetition - number <= 0    -> no sense 0 " do
    @validJob.repetition = 0
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - repetition - number = 1" do
    @validJob.repetition = 1
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - repetition - number = 10" do
    @validJob.repetition = 10
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Validate Parameter - delay - number = -1" do
    @validJob.delay = -1
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - delay - number = 0" do
    @validJob.delay = 0
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - delay - number = 1" do
    @validJob.delay = 1
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - delay - number = 10" do
    @validJob.delay = 10
    assert @validJob.save(), @validJob.errors.inspect
  end
  #### Validate Parameters END ####

  #### XYZ START ####

  #### XYZ END ####

end
