class JobTemplatesController < ApplicationController
  # GET /job_templates
  # GET /job_templates.xml
  def index
    @job_templates = JobTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @job_templates }
    end
  end

  # GET /job_templates/1
  # GET /job_templates/1.xml
  def show
    @job_template = JobTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job_template }
    end
  end

  # GET /job_templates/new
  # GET /job_templates/new.xml
  def new
    @job_template = JobTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job_template }
    end
  end

  # GET /job_templates/1/edit
  def edit
    @job_template = JobTemplate.find(params[:id])
  end

  # POST /job_templates
  # POST /job_templates.xml
  def create
    @job_template = JobTemplate.new(params[:job_template])

    respond_to do |format|
      if @job_template.save
        format.html { redirect_to(@job_template, :notice => 'Job template was successfully created.') }
        format.xml  { render :xml => @job_template, :status => :created, :location => @job_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /job_templates/1
  # PUT /job_templates/1.xml
  def update
    @job_template = JobTemplate.find(params[:id])

    respond_to do |format|
      if @job_template.update_attributes(params[:job_template])
        format.html { redirect_to(@job_template, :notice => 'Job template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /job_templates/1
  # DELETE /job_templates/1.xml
  def destroy
    @job_template = JobTemplate.find(params[:id])
    @job_template.destroy

    respond_to do |format|
      format.html { redirect_to(job_templates_url) }
      format.xml  { head :ok }
    end
  end
end
