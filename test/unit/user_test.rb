require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Missing password" do
    #No password is set.
    user = User.new(:username => "Jarqueline")
    assert !(user.save()), 'password required'
  end
  
  test "Missing username" do
      #No username is set.
      user = User.new(:password => "Jarqueli42")
      assert !(user.save()), 'username required'
  end
    
  test "Duplicate username" do
      #No username is set.
      user1 = User.new(:username => "Jarqueline", :password => "Jarqueli42")
      user2 = User.new(:username => "Jarqueline", :password => "Jarqueli42")
      
      assert (user1.save()), 'Should be stored'
      assert !(user2.save()), 'Username already exist'
  end
  
  test "Minimum length - username" do
      user = User.new(:username => "AB", :password => "Jarqueli42")
      
      assert !(user.save()), 'Invalid length, username too small'
  end
  
  test "Minimum length - password" do
      user = User.new(:username => "Jarqueline", :password => "42")
      
      assert !(user.save()), 'Invalid length, password too small'
  end
  
  test "Maximum length - username" do
        user = User.new(:username => "12345678901", :password => "Jarqueli42")
        
        assert !(user.save()), 'Invalid length, username too big'
  end
    
  test "Maximum length - password" do
      user = User.new(:username => "Jarqueline", :password => "1234567801")
      
      assert !(user.save()), 'Invalid length, password too big'
  end
  
  test "Validate characters - whitespace - username" do
        user = User.new(:username => "Jar ueline", :password => "Jarqueli42")
        
        assert !(user.save()), 'Invalid characters in username'
  end
    
  test "Validate characters - whitespace - password" do
      user = User.new(:username => "Jarqueline", :password => "Jarq eli42")
      
      assert !(user.save()), 'Invalid characters in password'
  end
  
  test "Validate characters - special characters - username" do
        user = User.new(:username => "J{(a#+=}ne", :password => "Jarqueli42")
        
        assert !(user.save()), 'Invalid special characters in username'
  end
    
  test "Validate characters - special characters - password" do
      user = User.new(:username => "Jarqueline", :password => "J{(a#+=e42")
      
      assert !(user.save()), 'Invalid special characters in password'
  end
end
