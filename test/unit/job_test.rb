require 'test_helper'

### TODO: validation for parameters missing: content, attachement
class JobTest < ActiveSupport::TestCase

  def setup
    @validJob = Job.new(valid_job_attributes)
  end
  
  test "Valid - Both fixtures belongs to AdminTest - Fixtures" do
	job = jobs(:one)
	assert_equal job.user.username, "AdminTest"
	
	job = jobs(:two)
	assert_equal job.user.username, "AdminTest"
  end

  test "Valid - Creating Valid Job  Object" do
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Invalid - Missing Parameters - destinations" do
	job = Job.new(valid_job_attributes(:destinations => nil))
	assert !job.save(), job.errors.inspect
  end
  
  test "Invalid - Missing Parameters - sender" do
	job = Job.new(valid_job_attributes(:sender => nil))
	assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - subject" do
	job = Job.new(valid_job_attributes(:subject => nil))
	assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - content" do
	job = Job.new(valid_job_attributes(:content => nil))
	assert !job.save(), job.errors.inspect
  end

  # DEPRECATED, not yet needed
  # test "Valid - Missing Parameters - attachement" do
	# job = Job.new(valid_job_attributes(:attachement => nil))
	# assert !job.save(), job.errors.inspect
  # end

  test "Invalid - Missing Parameters - kickOff" do
	job = Job.new(valid_job_attributes(:kickOff => nil))
	assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - repetition" do
	job = Job.new(valid_job_attributes(:repetition => nil))
	assert !job.save(), job.errors.inspect
  end

  test "Invalid - Missing Parameters - delay" do
	job = Job.new(valid_job_attributes(:delay => nil))
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

  test "Valid - Validate Parameter - destinations - invalid destinations doubleMail 01" do
    @validJob.destinations = "email1@host1.de;email12@host2.awe"
    assert @validJob.save(), @validJob.errors.inspect
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

  test "Valid - Validate Parameter - repetition - zero ok, no limit" do
    @validJob.repetition = 0
    assert @validJob.save(), @validJob.errors.inspect
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

  test "Invalid - Validate Parameter - delay - number = 0" do
    @validJob.delay = 0
    assert !@validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - delay - number = 1" do
    @validJob.delay = 1
    assert @validJob.save(), @validJob.errors.inspect
  end

  test "Valid - Validate Parameter - delay - number = 10" do
    @validJob.delay = 10
    assert @validJob.save(), @validJob.errors.inspect
  end
end
