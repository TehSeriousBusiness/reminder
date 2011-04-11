require 'test_helper'

### TODO: validation for parameters missing: content, attachment
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
  testVarInitiator = "testUserName"
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

  #### Validate Parameters START ####
  test "Validate Parameter - initiator - Valid Username" do
    # Job should have a validate_initiator, this method checks if the initiator exists in the user table
    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement valid username check (does a username with this name exists in the db?) within job model"
    #assert !(job.save()), 'delay required'
  end

  test "Validate Parameter - initiator - Valid Username Default: Anon" do
    # Job should have a validate_initiator, this method checks if the initiator exists in the user table
    username = "anon"
    job = Job.new(:initiator => username, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement valid username check (does a username with this name exists in the db?) within job model"
    #assert !(job.save()), 'delay required'
  end

  test "Validate Parameter - initiator - Valid Destinations" do
    # Job should have a validate_emailFormat, this method checks if the email can be valid
    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement email format check within job model"
    #assert !(job.save()), 'delay required'
  end

  test "Validate Parameter - subject - length check, longer than 254" do
    # this parameter is longer than 254 chars
    subject = "";
    # loop 255 times and add a s to the string -> creating a string longer than 254
    for i in 1..255 do
      subject = subject + "s"
    end

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => subject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert !(job.save()), 'subject invalid, to long, length must be under 254 chars'
  end

  test "Validate Parameter - subject - length check, smaller than 254" do
    # this parameter is longer than 254 chars
    subject = "";
    # loop 255 times and add a s to the string -> creating a string longer than 254
    for i in 1..254 do
      subject = subject + "s"
    end

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => subject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert !(job.save()), 'subject invalid, to long, length must be under 254 chars'
  end

  test "Validate Parameter - kickOff - Valid Date -> must be in the future" do
    # Job should have a validate_Time, this method checks if the time is in the future or past (future is valid, past is invalid)
    time = Time.now() - 1 # -> sets the time to now - 1 second

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => time, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement time check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - kickOff - Valid Date -> must be in the future" do
    # Job should have a validate_Time, this method checks if the time is in the future or past (future is valid, past is invalid)
    time = Time.now() + 200 # -> sets the time to now + 200 second

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => time, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement time check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - repetition - A valid repetition should be bigger than zero" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than zero
    repNumber = 0

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => repNumber, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - repetition - A valid repetition should be bigger than zero" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than zero
    repNumber = 1

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => repNumber, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - repetition - A valid repetition should be bigger than zero" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than zero
    repNumber = 3

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => repNumber, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - delay - A valid delay should be bigger than -1" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than -1
    delay = -1

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - delay - A valid delay should be bigger than -1" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than -1
    delay = 0

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end

  test "Validate Parameter - delay - A valid delay should be bigger than -1" do
    # Job should have a validate_intNumber, this method checks if the number is bigger than -1
    delay = 5

    job = Job.new(:initiator => testVarInitiator, :destinations => testVarDestinations, :subject => testVarSubject, :content => testVarContent, :attachment => testVarAttachment, :kickOff => testVarKickOff, :repetition => testVarRepetition, :delay => testVarDelay)
    assert false, "method not yet ready, implement number check within job model"
    #assert !(job.save()), 'kickoff time is invalid, the time should be in the future'
  end
  #### Validate Parameters END ####

  #### XYZ START ####

  #### XYZ END ####

end
