class UsersController < ApplicationController
  before_filter :login_required, :except => [:login, :process_login, :new, :create]
  
  # GET /users
  # GET /users.xml
  def index
	@users = (@user.username == "Admin")? User.all : [ @user ]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  #{ render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(:username => params[:username], :password => params[:password])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # site used for login
  #http://www.devarticles.com/c/a/Ruby-on-Rails/Login-Systems-and-More-with-Ruby-on-Rails/
  def login
    unless session[:id].nil?
		redirect_to session[:return_to] || '/myPage'
    end
  end

  def process_login
	# reset the left over from the last session, this is necessary if the session started without doing a login first
	reset_session
    # check if user pressed anon button
    if(params[:commit] == "LoginAnon")
      @user = User.find_by_username("Anon")
      session[:id] = @user.id
      redirect_to '/myPage'
    else
      if (user = User.authenticate(params[:username], params[:password]))
        session[:id] = user.id # Remember the user's id during this session
        redirect_to '/myPage'
      else
         flash[:error] = 'Invalid login.'
		 redirect_to '/'
      end
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end
end
