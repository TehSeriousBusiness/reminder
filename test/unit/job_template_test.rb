require 'test_helper'

# members to test:
#   - templateName    : chosen freely, max. 40 characters. Required & unqiue!
#   - templateSubject : chosen freely, max. 40 characters.
#   - templateContent : chosen freely, max. 250 characters
#
#   all member vars are modifiable.

# 5 Failures on start (wihtout class implementation)

class JobTemplateTest < ActiveSupport::TestCase
  
  test "Missing templateName" do
    #No templateName is set.
    jobTemplate = JobTemplate.new(:templateSubject => "Unknown subject", :templateContent => "Unknown content")
    assert !(jobTemplate.save()), 'templateName required'
  end
    
  # valid on start
  test "TemplateName only" do
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName")
    assert (jobTemplate.save()), 'templateName only is acceptable'
  end
  
  test "Duplicate templateName" do
      #No templateName is set.
      templateJob1 = JobTemplate.new(:templateName => "A simple template name")
      templateJob2 = JobTemplate.new(:templateName => "A simple template name")
      
      # TODO: Break up in two methods? (one assertion per method!)
      assert (templateJob1.save()), 'Should be stored'
      assert !(templateJob2.save()), 'templateName already exist'
  end
  
  # valid on start
  test "Change templateName" do
    jobTemplate = JobTemplate.new(:templateName => "Old TemplateName", :templateSubject => "Unknown subject", :templateContent => "Unknown content")
    jobTemplate.templateName = "New TemplateName"
    
    assert_equal "New TemplateName", jobTemplate.templateName, "templateName is not modifiable"
  end
  
  # valid on start
  test "Change templateSubject" do
    jobTemplate = JobTemplate.new(:templateName => "TemplateName", :templateSubject => "Old Unknown subject", :templateContent => "Unknown content")
    jobTemplate.templateSubject = "New Unknown subject"
    
    assert_equal "New Unknown subject", jobTemplate.templateSubject, "templateSubject is not modifiable"
  end
    
  # valid on start
  test "Change templateContent" do
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "Unknown subject", :templateContent => "Old Unknown content")
    jobTemplate.templateContent = "New Unknown content"
    
    assert_equal "New Unknown content", jobTemplate.templateContent, "templateContent is not modifiable"
  end
  
  
  # valid on start  
  test "Valid maximum length - templateName" do
    #Test valid templateName, 40 characters.
    jobTemplate = JobTemplate.new(:templateName => "1234567890123456789012345678901234567890")
    assert (jobTemplate.save()), 'valid length of templateName, maximum is 40 characters.'
  end
  
  test "Invalid maximum length - templateName" do
    #Test invalid templateName, 41 characters.
    jobTemplate = JobTemplate.new(:templateName => "12345678901234567890123456789012345678901")
    assert !(jobTemplate.save()), 'invalid length of templateName, maximum is 40 characters.'
  end
  
  # valid on start
  test "Valid maximum length - templateSubject" do
    #Test valid templateSubject, 40 characters.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "1234567890123456789012345678901234567890")
    assert (jobTemplate.save()), 'Valid length of templateSubject, maximum is 40 characters.'
  end
  
  test "Invalid maximum length - templateSubject" do
    #Test invalid templateSubject, 41 characters.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "12345678901234567890123456789012345678901")
    assert !(jobTemplate.save()), 'invalid length of templateSubject, maximum is 40 characters.'
  end
  
  # valid on start
  test "Valid maximum length - templateContent" do
    #Test valid templateContent, 250 characters.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateContent => "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890")
    assert (jobTemplate.save()), 'Valid length of templateContent, maximum is 250 characters.'
  end
  
  test "Invalid maximum length - templateContent" do
    #Test invalid templateContent, 251 characters.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateContent => "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901")
    assert !(jobTemplate.save()), 'Invalid length of templateContent, maximum is 250 characters.'
  end
  
end
