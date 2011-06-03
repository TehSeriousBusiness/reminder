require 'test_helper'

# member vars
#   - address : String, unique, max length = 40
#   - password : String,        max length = 40
#   - host : String,            max length = 40
#   - port : integer, range: [0, 65535]

# all members modifiable, required

# Total tests : 19, expected failures : 10

class MailServerTest < ActiveSupport::TestCase
	test "valid_mail_server_attributes" do
		mailServer = MailServer.new(valid_mail_server_attributes)
		assert mailServer.save()
	end
  
  test "Invalid - Missing address" do
    mailServer = MailServer.new(:password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'address required'
  end
  
  test "Invalid - Missing password" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'password required'
  end
  
  test "Invalid - Missing host" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :port => 80)
    assert !(mailServer.save()), 'host required'
  end
  
  test "Invalid - Missing port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de")
    assert !(mailServer.save()), 'port required'
  end
  
  test "Invalid - Duplicate address" do
      mailServer1 = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
      mailServer2 = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
      
      # TODO: Break up in two methods? (one assertion per method!)
      assert (mailServer1.save()), 'Should be stored'
      assert !(mailServer2.save()), 'address already exist'
  end
  
  test "Valid - Change address" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    mailServer.address = "NewSimpleAddress@web.de"
    
    assert_equal "NewSimpleAddress@web.de", mailServer.address, "address is not modifiable"
  end
  
  test "Valid - Change password" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    mailServer.password = "NewSimplePassword"
    
    assert_equal "NewSimplePassword", mailServer.password, "password is not modifiable"
  end
  
  test "Valid - Change host" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    mailServer.host = "smtp.gmx.de"
    
    assert_equal "smtp.gmx.de", mailServer.host, "host is not modifiable"
  end
  
  test "Valid - Change port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    mailServer.port = 8080
    
    assert_equal 8080, mailServer.port, "port is not modifiable"
  end
   
  test "Valid maximum length - address" do
    #Test valid address, 40 characters.
    mailServer = MailServer.new(:address => "1234567890123456789012345678901234567890", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    assert (mailServer.save()), 'valid length of address, maximum is 40 characters.'
  end
  
  test "Invalid maximum length - address" do
    #Test invalid address, 41 characters.
    mailServer = MailServer.new(:address => "12345678901234567890123456789012345678901", :password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'invalid length of address, maximum is 40 characters.'
  end
  
  test "Valid maximum length - password" do
    #Test valid password, 40 characters.
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "1234567890123456789012345678901234567890", :host => "smtp.web.de", :port => 80)
    assert (mailServer.save()), 'valid length of password, maximum is 40 characters.'
  end
  
  test "Invalid maximum length - password" do
    #Test invalid password, 41 characters.
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "12345678901234567890123456789012345678901", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'invalid length of password, maximum is 40 characters.'
  end
  
  test "Valid maximum length - host" do
    #Test valid host, 40 characters.
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "1234567890123456789012345678901234567890", :port => 80)
    assert (mailServer.save()), 'valid length of host, maximum is 40 characters.'
  end
  
  test "Invalid maximum length - host" do
    #Test invalid host, 41 characters.
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "12345678901234567890123456789012345678901", :port => 80)
    assert !(mailServer.save()), 'invalid length of host, maximum is 40 characters.'
  end
    
  test "Invalid lower bound - port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => -1)
    assert !(mailServer.save()), 'Invalid lower bound of port! Range is [0, 65535].'
  end
  
  test "Valid lower bound - port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 0)
    assert (mailServer.save()), 'Valid lower bound of port! Range is [0, 65535].'
  end
    
  test "Valid upper bound - port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 65535)
    assert (mailServer.save()), 'Valid upper bound of port! Range is [0, 65535].'
  end
  
  test "Invalid upper bound - port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de", :port => 65536)
    assert !(mailServer.save()), 'Invalid upper bound of port! Range is [0, 65535].'
  end
end
