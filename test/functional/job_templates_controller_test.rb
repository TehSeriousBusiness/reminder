require 'test_helper'

class JobTemplatesControllerTest < ActionController::TestCase
  setup do
    @job_template = job_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_template" do
    assert_difference('JobTemplate.count') do
		@job_template.templateName = "NEW"
		post :create, :job_template => @job_template.attributes
    end

    assert_redirected_to job_template_path(assigns(:job_template))
  end

  test "should show job_template" do
    get :show, :id => @job_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @job_template.to_param
    assert_response :success
  end

  test "should update job_template" do
    put :update, :id => @job_template.to_param, :job_template => @job_template.attributes
    assert_redirected_to job_template_path(assigns(:job_template))
  end

  test "should destroy job_template" do
    assert_difference('JobTemplate.count', -1) do
      delete :destroy, :id => @job_template.to_param
    end

    assert_redirected_to job_templates_path
  end
end
