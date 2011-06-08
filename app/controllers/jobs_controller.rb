class JobsController < ApplicationController
	before_filter :login_required
	
	# Create new job for user and set default values.
	def createJobWithDefaults
		@job = @user.jobs.new
		@job.sender = "Average Joe <average.joe@gmx.net>"
		@job.destinations = "recipient@gmx.net"
		@job.subject = "A Simple Subject"
		@job.content = "This is a simple test content!\n\n#{Time.now.localtime}"
		@job.repetition = 2
		@job.delay = 10
	end
	
	
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = @user.jobs

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
	@job = @user.jobs.find(params[:id])
	#if find fails, redirect to the controller
	rescue
		flash[:error] = 'Record not found'
		redirect_to :controller => 'jobs'
		return
	

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    createJobWithDefaults

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
		# send mail now or later...
		Background.instance.delay.sendLater(@job)
	  
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
  
  def destroyall
    @jobs = @user.jobs

	#iterate through all jobs and destory each at a time
	@jobs.each do | job |
		job.destroy
	end
	
    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  ## select the template and fill a job with the template information
  def selecttemplate
	@templates = JobTemplate.all
  end
  
  def newByTemplate
	@template = JobTemplate.find(params[:id])
	createJobWithDefaults
	
	# Use the Template values
	@job.subject = @template.templateSubject
	@job.content = @template.templateContent
  end
end
