class JobsController < ApplicationController
	before_filter :login_required
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = @user.jobs
	
	Background.instance.sendLater

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = @user.jobs.find_by_id(params[:id])
	
	if @job.nil?
		return redirect_to '/'
	end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = @user.jobs.new
	
	# Set default values here!
	@job.destinations = "no-reply@gmx.net"
	@job.subject = "A Simple Subject"
	@job.content = "This is a simple test content!\n\n#{Time.now.localtime}"
	@job.repetition = 2
	@job.delay = 60

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = @user.jobs.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = @user.jobs.new(params[:job])

    respond_to do |format|
      if @job.save
	  
		#void method
		UserMailer.send_mail(@job)
	  
        format.html { redirect_to(@job, :notice => 'Job was successfully created.') }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = @user.jobs.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to(@job, :notice => 'Job was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = @user.jobs.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  def destroy_all
	puts "DESTROYING ALL - HELLO WORLD!"
  
	@user.jobs.each do |currentJob|
		currentJob.destroy
	end
	
    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
