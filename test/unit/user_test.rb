require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Invalid - Missing password" do
    #No password is set.
    user = User.new(:username => "Jarqueline")
    assert !(user.save()), 'password required'
  end
  
  test "Invalid - Missing username" do
      #No username is set.
      user = User.new(:password => "Jarqueli42")
      assert !(user.save()), 'username required'
  end
    
  test "Invalid - Duplicate username" do
      #No username is set.
      user1 = User.new(:username => "Jarqueline", :password => "Jarqueli42")
      user2 = User.new(:username => "Jarqueline", :password => "Jarqueli42")
      
      # TODO: Break up in two methods? (one assertion per method!)
      assert (user1.save()), 'Should be stored'
      assert !(user2.save()), 'Username already exist'
  end
  
  test "Invalid - Name already in use" do
    user1 = User.new(:username => "Hans", :password => "Jarqueli42")
    user2 = User.new(:username => "Peter", :password => "Jarqueli42")
    
    #Store both in db, ok
    assert user1.save()
    assert user2.save()
    
    #Change name and try to store again... should failing now!
    user1.username = user2.username
    assert !user1.save()
  end
  
  test "Valid - Change name and check DB" do
    user = User.new(:username => "Hans", :password => "Jarqueli42")
    assert user.save()
    
    user.username = "Peter"
    assert user.save()
    
    #DB must have exact 1 entry!
    found = User.find_by_username("Hans")
    assert found == nil
    
    found = User.find_by_username("Peter")
    assert found != nil
    assert_equal "Peter", found.username
    assert_equal "Jarqueli42", found.password
  end
  
  test "Valid - Store and find user from DB" do
    user = User.new(:username => "Hans", :password => "Jarqueli42")
    assert user.save()
    found = User.find_by_username("Hans")
    
    assert found != nil
    assert_equal "Hans", found.username
    assert_equal "Jarqueli42", found.password
  end
  
  test "Invalid - Minimum length - username" do
      user = User.new(:username => "AB", :password => "Jarqueli42")
      assert !(user.save()), 'Invalid length, username too small'
  end
  
  test "Invalid - Minimum length - password" do
      user = User.new(:username => "Jarqueline", :password => "42")
      assert !(user.save()), 'Invalid length, password too small'
  end
  
  test "Invalid - Maximum length - username" do
        user = User.new(:username => "12345678901", :password => "Jarqueli42")
        assert !(user.save()), 'Invalid length, username too big'
  end
    
  test "Invalid - Maximum length - password" do
      user = User.new(:username => "Jarqueline", :password => "12345678901")
      assert !(user.save()), 'Invalid length, password too big'
  end
  
  test "Invalid - Validate characters - whitespace - username" do
        user = User.new(:username => "Jar ueline", :password => "Jarqueli42")
        assert !(user.save()), 'Invalid characters in username'
  end
    
  test "Invalid - Validate characters - whitespace - password" do
      user = User.new(:username => "Jarqueline", :password => "Jarq eli42")
      assert !(user.save()), 'Invalid characters in password'
  end
  
  test "Invalid - Validate characters - special characters - username" do
        user = User.new(:username => "J{(a#+=}ne", :password => "Jarqueli42")
        assert !(user.save()), 'Invalid special characters in username'
  end
    
  test "Invalid - Validate characters - special characters - password" do
      user = User.new(:username => "Jarqueline", :password => "J{(a#+=e42")
      assert !user.save, 'Invalid special characters in password'
  end
end
