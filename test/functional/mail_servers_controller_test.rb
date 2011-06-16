require 'test_helper'

class MailServersControllerTest < ActionController::TestCase
  setup do
	@user = users(:one)
	session[:id] = @user.id
    @mail_server = mail_servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_server" do
    assert_difference('MailServer.count') do
		@mail_server.address = "mail@serv.er"
		post :create, :mail_server => @mail_server.attributes
    end

    assert_redirected_to mail_server_path(assigns(:mail_server))
  end

  test "should show mail_server" do
    get :show, :id => @mail_server.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mail_server.to_param
    assert_response :success
  end

  test "should update mail_server" do
    put :update, :id => @mail_server.to_param, :mail_server => @mail_server.attributes
    assert_redirected_to mail_server_path(assigns(:mail_server))
  end

  test "should destroy mail_server" do
    assert_difference('MailServer.count', -1) do
      delete :destroy, :id => @mail_server.to_param
    end

    assert_redirected_to mail_servers_path
  end
end
