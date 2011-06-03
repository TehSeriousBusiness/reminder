require 'test_helper'

# members to test:
#   - templateName    : chosen freely, max. 40 characters. Required & unqiue!
#   - templateSubject : chosen freely, max. 40 characters. Required
#   - templateContent : chosen freely, max. 250 characters Required
#
#   all member vars are modifiable.

# 5 Failures on start (wihtout class implementation)

class JobTemplateTest < ActiveSupport::TestCase
	def setup
		@validJobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "Unknown subject", :templateContent => "Unknown content")
	end

  
	test "valid_job_template_attributes" do
		jobTemplate = JobTemplate.new(valid_job_template_attributes)
		assert jobTemplate.save()
	end
  
  test "Invalid - Missing templateName" do
    #No templateName is set.
    jobTemplate = JobTemplate.new(:templateSubject => "Unknown subject", :templateContent => "Unknown content")
    assert !(jobTemplate.save()), 'templateName required'
  end
  
  test "Invalid - Missing templateSubject" do
    #No templateName is set.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateContent => "Unknown content")
    assert !(jobTemplate.save()), 'templateSubject required'
  end
  
  test "Invalid - Missing templateContent" do
    #No templateName is set.
    jobTemplate = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "Unknown subject")
    assert !(jobTemplate.save()), 'templateContent required'
  end
    
  test "Valid - Template" do
    assert (@validJobTemplate.save())
  end
  
  test "Invalid Duplicate templateName" do
      templateJob1 = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "Unknown subject", :templateContent => "Unknown content")
      templateJob2 = JobTemplate.new(:templateName => "MyTemplateName", :templateSubject => "Unknown subject", :templateContent => "Unknown content")
      
      assert (templateJob1.save()), 'Should be stored'
      assert !(templateJob2.save()), 'templateName already exist'
  end
  
  test "Valid - Change templateName" do
    @validJobTemplate.templateName = "New TemplateName"
    
    assert_equal "New TemplateName", @validJobTemplate.templateName, "templateName is not modifiable"
  end
  
  test "Valid - Change templateSubject" do
    @validJobTemplate.templateSubject = "New Unknown subject"
    assert_equal "New Unknown subject", @validJobTemplate.templateSubject, "templateSubject is not modifiable"
  end
    
  test "Valid - Change templateContent" do
    @validJobTemplate.templateContent = "New Unknown content"
    assert_equal "New Unknown content", @validJobTemplate.templateContent, "templateContent is not modifiable"
  end
    
  test "Valid - Valid maximum length - templateName" do
    #Test valid templateName, 40 characters.
	@validJobTemplate.templateName = "1234567890123456789012345678901234567890"
    assert (@validJobTemplate.save()), 'valid length of templateName, maximum is 40 characters.'
  end
  
  test "Invalid - Invalid maximum length - templateName" do
    #Test invalid templateName, 41 characters.
    @validJobTemplate.templateName = "12345678901234567890123456789012345678901"
    assert !(@validJobTemplate.save()), 'invalid length of templateName, maximum is 40 characters.'
  end
  
  test "Valid -  Valid maximum length - templateSubject" do
    #Test valid templateSubject, 40 characters.
    @validJobTemplate.templateSubject = "1234567890123456789012345678901234567890"
    assert (@validJobTemplate.save()), 'Valid length of templateSubject, maximum is 40 characters.'
  end
  
  test "Invalid - Invalid maximum length - templateSubject" do
    #Test invalid templateSubject, 41 characters.
    @validJobTemplate.templateSubject = "12345678901234567890123456789012345678901"
    assert !(@validJobTemplate.save()), 'invalid length of templateSubject, maximum is 40 characters.'
  end
  
  test "Valid -  Valid maximum length - templateContent" do
    #Test valid templateContent, 250 characters.
    @validJobTemplate.templateContent = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    assert (@validJobTemplate.save()), 'Valid length of templateContent, maximum is 250 characters.'
  end
  
  test "Invalid - Invalid maximum length - templateContent" do
    #Test invalid templateContent, 251 characters.
    @validJobTemplate.templateContent = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
    assert !(@validJobTemplate.save()), 'Invalid length of templateContent, maximum is 250 characters.'
  end
  
end
