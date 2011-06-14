require 'test_helper'

##beispiele für assert_select http://content.labnotes.org/assert_select/assert_select.html
#assert_select "html:root>head>title", "Login"
#assert_select "form[action=?]", url_for(:action=>"login") do
#  assert_select "input[type=text][name=username]"
#  assert_select "input[type=password][name=password]"
#end

class JobsControllerTest < ActionController::TestCase
  setup do
	@user = users(:one)
    @job = jobs(:one)
	@template = job_templates(:one)
	session[:id] = @user.id
  end

  #maybe move this to something like application_controller_test.rb
  test "should get title" do
	get :index
	assert_select 'title', 'Reminder'
  assert_match /Reminder/, response.body
  end
  
    test "should get 3 links, destroy all, new and newfromtemplate" do
	get :index
	#assert_select "html:root>head>body>", "Destroy ALL"
	assert_match /Destroy ALL/, response.body
	assert_match /New Job/, response.body
	assert_match /New Job From Template/, response.body
  end
  
  test "should get job from a template" do
	get(:newByTemplate, {'id' => @template.id})
	assert_select "input#job_subject[value="+@template.templateSubject+"]"
	assert_select "textarea#job_content" # TODO get the "value" between the textarea tags and compare it
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
		@job.destinations = "destin@tio.ns"
		post :create, :job => @job.attributes
    end

    assert_redirected_to job_path(assigns(:job))
  end

  test "should show job" do
    get :show, :id => @job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @job.to_param
    assert_response :success
  end

  test "should update job" do
    put :update, :id => @job.to_param, :job => @job.attributes
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, :id => @job.to_param
    end

    assert_redirected_to jobs_path
  end
  
  test "should destroyall job" do
  	#setup a user
	@user = users(:one)
	session[:id] = @user
	get(:destroyall, {'user' => @user})
    assert_response :redirect

    assert_redirected_to jobs_path
  end
end
