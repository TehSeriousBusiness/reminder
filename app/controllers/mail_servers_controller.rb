class MailServersController < ApplicationController
  before_filter :login_required
  
  # GET /mail_servers
  # GET /mail_servers.xml
  def index
    @mail_servers = MailServer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mail_servers }
    end
  end

  # GET /mail_servers/1
  # GET /mail_servers/1.xml
  def show
    @mail_server = MailServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mail_server }
    end
  end

  # GET /mail_servers/new
  # GET /mail_servers/new.xml
  def new
    @mail_server = MailServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mail_server }
    end
  end

  # GET /mail_servers/1/edit
  def edit
    @mail_server = MailServer.find(params[:id])
  end

  # POST /mail_servers
  # POST /mail_servers.xml
  def create
    @mail_server = MailServer.new(params[:mail_server])

    respond_to do |format|
      if @mail_server.save
        format.html { redirect_to(@mail_server, :notice => 'Mail server was successfully created.') }
        format.xml  { render :xml => @mail_server, :status => :created, :location => @mail_server }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mail_server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mail_servers/1
  # PUT /mail_servers/1.xml
  def update
    @mail_server = MailServer.find(params[:id])

    respond_to do |format|
      if @mail_server.update_attributes(params[:mail_server])
        format.html { redirect_to(@mail_server, :notice => 'Mail server was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mail_server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_servers/1
  # DELETE /mail_servers/1.xml
  def destroy
    @mail_server = MailServer.find(params[:id])
    @mail_server.destroy

    respond_to do |format|
      format.html { redirect_to(mail_servers_url) }
      format.xml  { head :ok }
    end
  end
end
