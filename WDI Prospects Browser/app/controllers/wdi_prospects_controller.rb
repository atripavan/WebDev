require 'csv'

class WdiProspectsController < ApplicationController

  # GET /wdi_prospects/1
  # GET /wdi_prospects/1.json
  def show
    @wdi_prospect = WdiProspect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wdi_prospect }
    end
  end

  # GET /wdi_prospects/new
  # GET /wdi_prospects/new.json
  def new
    sessUser = session[:user_id]
    if sessUser      
      @wdi_prospect = WdiProspect.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @wdi_prospect }
      end
    else
      redirect_to '/log_in'
    end
  end

  # GET /wdi_prospects/1/edit
  def edit
    @wdi_prospect = WdiProspect.find(params[:id])
  end

  # POST /wdi_prospects
  # POST /wdi_prospects.json
  def create
    @wdi_prospect = WdiProspect.new(params[:wdi_prospect])
    chngStr = "<b>Created a prospect with EIN: "+params[:wdi_prospect][:e_i_n]+"</b>"
    respond_to do |format|
      if @wdi_prospect.save
        @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chngStr)
        @change_history.save
        format.html { redirect_to @wdi_prospect, notice: 'Wdi prospect was successfully created.' }
        format.json { render json: @wdi_prospect, status: :created, location: @wdi_prospect }
      else
        format.html { render action: "new" }
        format.json { render json: @wdi_prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wdi_prospects/1
  # PUT /wdi_prospects/1.json
  def update
    @wdi_prospect = WdiProspect.find(params[:id])
    
    #Create entry to change history table
    #Find out the fields that are changed
    #<b> are added to make them appear bold in the view
    chngStr = "<b><u>Edited EIN: "+ @wdi_prospect.e_i_n
    chngStr = chngStr +" with below changes:</u></b>"
    if @wdi_prospect.e_i_n != params[:wdi_prospect][:e_i_n]
      chngStr = "<br/>E I N: " + params[:wdi_prospect][:e_i_n]
    end
    if @wdi_prospect.name != params[:wdi_prospect][:name]
      chngStr = chngStr +"<br/>"+"Name: "+params[:wdi_prospect][:name]
    end
    if @wdi_prospect.in_care_of_name != params[:wdi_prospect][:in_care_of_name]
      chngStr = chngStr +"<br/>"+"In Care Of Name: "+params[:wdi_prospect][:in_care_of_name]
    end
    if @wdi_prospect.address != params[:wdi_prospect][:address]
      chngStr = chngStr +"<br/>"+"Address: "+params[:wdi_prospect][:address]
    end
    if @wdi_prospect.city != params[:wdi_prospect][:city]
      chngStr = chngStr +"<br/>"+"City: "+params[:wdi_prospect][:city]
    end
    if @wdi_prospect.state != params[:wdi_prospect][:state]
      chngStr = chngStr +"<br/>"+"State: "+params[:wdi_prospect][:state]
    end
    if @wdi_prospect.zip_code != params[:wdi_prospect][:zip_code]
      chngStr = chngStr +"<br/>"+"Zip Code: "+params[:wdi_prospect][:zip_code]
    end

    params[:wdi_prospect][:asset_amount] != "" ? astAmnt = params[:wdi_prospect][:asset_amount] : astAmnt = ""      
    if String(@wdi_prospect.asset_amount) != astAmnt
      chngStr = chngStr +"<br/>"+"Asset Amount: "+astAmnt
    end
    
    params[:wdi_prospect][:income_amount] != "" ? incAmnt = params[:wdi_prospect][:income_amount] : incAmnt = ""
    if String(@wdi_prospect.income_amount) != incAmnt
      chngStr = chngStr +"<br/>"+"Income Amount: "+incAmnt
    end
    
    params[:wdi_prospect][:form_990_revenue_amount] != "" ? formAmnt = params[:wdi_prospect][:form_990_revenue_amount] : formAmnt = ""
    if String(@wdi_prospect.form_990_revenue_amount) != formAmnt
      chngStr = chngStr +"<br/>"+"Form 990 Revenue Amount: "+formAmnt
    end
    
    respond_to do |format|
      if @wdi_prospect.update_attributes(params[:wdi_prospect])
        @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chngStr)
        @change_history.save
        format.html { redirect_to @wdi_prospect, notice: 'Wdi prospect was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wdi_prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wdi_prospects/1
  # DELETE /wdi_prospects/1.json
  def destroy
    @wdi_prospect = WdiProspect.find(params[:id])

    chng = "<b>Deleted Prospect with EIN: "+@wdi_prospect.e_i_n+"</b>"
    @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chng)
    @change_history.save
      
    @wdi_prospect.destroy

    respond_to do |format|
      format.html { redirect_to "/search" }
    end
  end
  
  # Search functionality
  def search
    sessUser = session[:user_id]
    if sessUser        
      @wdi_prospects = WdiProspect.search(params[:srchName], params[:srchEin], params[:srchInCareOfName],
                params[:srchAddr], params[:srchCity], params[:srchState], params[:srchZipCode], 
                  params[:srchAstAmnt], params[:srchIncAmnt], params[:srchFrm990RvnAmnt], params[:recLimit])      
      respond_to do |format|
        format.html
        format.json { render json: @wdi_prospects }
      end
    else
      redirect_to '/log_in'
    end
  end
  
  # uploadfile
  def uploadfile
    sessUser = session[:user_id]
    if sessUser 
      render :file => 'wdi_prospects/uploadfile.html.erb'
    else
      redirect_to '/log_in'
    end
  end
  
  # Action class to Import records from CSV into wdi_prospects
  def import
    srcFile = params[:file]
    n=0
    CSV.foreach(srcFile.path, :headers => true) do |row|
      WdiProspect.create({
      :e_i_n => row[0],
      :name => row[1],    
      :in_care_of_name => row[2],
      :address => row[3],
      :city => row[4],
      :state => row[5],
      :zip_code => row[6],
      :asset_amount => replChar(row[25]),
      :income_amount => replChar(row[26]),
      :form_990_revenue_amount => replChar(row[28])
      })
      n=n+1
    end
    respond_to do |format|
      format.html { 
        flash[:notice] = "#{n} Records imported successfully"
        render :file => "wdi_prospects/uploadfile.html.erb" 
      }
end
  end
  
  #Util function used in import action to remove unwanted characters
  def replChar(amount)
    if amount.strip.length!=0
      amount=amount.strip
      amount.gsub!('$','')
      amount.gsub!(',','')
    end
  return amount
  end
  
  # Action class to delete multiple prospects
  def delProspects
#    session[:return_to] = request.fullpath
    params[:delProspectIds].split("$").each do |id|
      @wdi_prospect = WdiProspect.find(id)
      
      chng = "<b>Deleted Prospect with EIN: "+@wdi_prospect.e_i_n+"</b>"
      @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chng)
      @change_history.save
      
      @wdi_prospect.destroy
    end
    #redirect_to(session[:return_to] || "/search")
#    session[:return_to] = nil
    respond_to do |format|
      format.html { render action: "search" }
    end
  rescue => e
    return e.message
  end
  
end
