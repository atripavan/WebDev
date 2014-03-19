class WdiRefinedProspectsController < ApplicationController

  # GET /wdi_refined_prospects/1
  # GET /wdi_refined_prospects/1.json
  def show
@wdi_refined_prospect = WdiRefinedProspect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wdi_refined_prospect }
    end
  end

  # GET /wdi_refined_prospects/new
  # GET /wdi_refined_prospects/new.json
  def new
    sessUser = session[:user_id]
    if sessUser      
      @wdi_refined_prospect = WdiRefinedProspect.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @wdi_refined_prospect }
      end
    else
      redirect_to '/log_in'
    end
  end

  # GET /wdi_refined_prospects/1/edit
  def edit
    @wdi_refined_prospect = WdiRefinedProspect.find(params[:id])
  end

  # POST /wdi_refined_prospects
  # POST /wdi_refined_prospects.json
  def create
    @wdi_refined_prospect = WdiRefinedProspect.new(params[:wdi_refined_prospect])
    chngStr = "<b>Created Refined prospect with EIN: "+params[:wdi_refined_prospect][:e_i_n]+"</b>"
    respond_to do |format|
      if @wdi_refined_prospect.save
        @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chngStr)
        @change_history.save
        format.html { redirect_to @wdi_refined_prospect, notice: 'Prospect was successfully created.' }
        format.json { render json: @wdi_refined_prospect, status: :created, location: @wdi_refined_prospect }
      else
        format.html { render action: "new" }
        format.json { render json: @wdi_refined_prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wdi_refined_prospects/1
  # PUT /wdi_refined_prospects/1.json
  def update
    @wdi_refined_prospect = WdiRefinedProspect.find(params[:id])
    
    chngStr = "<b><u>Edited EIN: "+ String(@wdi_refined_prospect.e_i_n)
    chngStr = chngStr +" with below changes:</u></b>"
    if @wdi_refined_prospect.e_i_n != params[:wdi_refined_prospect][:e_i_n]
      chngStr = "<br/>E I N: " + params[:wdi_refined_prospect][:e_i_n]
    end
    if @wdi_refined_prospect.name != params[:wdi_refined_prospect][:name]
      chngStr = chngStr +"<br/>"+"Name: "+params[:wdi_refined_prospect][:name]
    end
    if @wdi_refined_prospect.address != params[:wdi_refined_prospect][:address]
      chngStr = chngStr +"<br/>"+"Address: "+params[:wdi_refined_prospect][:address]
    end
    if @wdi_refined_prospect.city != params[:wdi_refined_prospect][:city]
      chngStr = chngStr +"<br/>"+"City: "+params[:wdi_refined_prospect][:city]
    end
    if @wdi_refined_prospect.state != params[:wdi_refined_prospect][:state]
      chngStr = chngStr +"<br/>"+"State: "+params[:wdi_refined_prospect][:state]
    end
    
    params[:wdi_refined_prospect][:income_amount] != "" ? incAmnt = params[:wdi_refined_prospect][:income_amount] : incAmnt = ""
    if String(@wdi_refined_prospect.income_amount) != incAmnt
      chngStr = chngStr +"<br/>"+"Income Amount: "+incAmnt
    end
    if @wdi_refined_prospect.first_name != params[:wdi_refined_prospect][:first_name]
      chngStr = chngStr +"<br/>"+"First Name: "+params[:wdi_refined_prospect][:first_name]
    end
    if @wdi_refined_prospect.last_name != params[:wdi_refined_prospect][:last_name]
      chngStr = chngStr +"<br/>"+"Last Name: "+params[:wdi_refined_prospect][:last_name]
    end
    if @wdi_refined_prospect.email != params[:wdi_refined_prospect][:email]
      chngStr = chngStr +"<br/>"+"Email: "+params[:wdi_refined_prospect][:email]
    end
    if @wdi_refined_prospect.title != params[:wdi_refined_prospect][:title]
      chngStr = chngStr +"<br/>"+"Title: "+params[:wdi_refined_prospect][:title]
    end
    if @wdi_refined_prospect.has_donation_button != params[:wdi_refined_prospect][:has_donation_button]
      chngStr = chngStr +"<br/>"+"Donation Button: "+params[:wdi_refined_prospect][:has_donation_button]
    end
    if @wdi_refined_prospect.website != params[:wdi_refined_prospect][:website]
      chngStr = chngStr +"<br/>"+"Website: "+params[:wdi_refined_prospect][:website]
    end
    
    respond_to do |format|
      if @wdi_refined_prospect.update_attributes(params[:wdi_refined_prospect])
        @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chngStr)
        @change_history.save
        format.html { redirect_to @wdi_refined_prospect, notice: 'Wdi prospect was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wdi_refined_prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wdi_refined_prospects/1
  # DELETE /wdi_refined_prospects/1.json
  def destroy
    @wdi_refined_prospect = WdiRefinedProspect.find(params[:id])

    chng = "<b>Deleted Refined Prospect with EIN: "+String(@wdi_refined_prospect.e_i_n)+"</b>"
    @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chng)
    @change_history.save
      
    @wdi_refined_prospect.destroy

    respond_to do |format|
      format.html { redirect_to "/search_refined_prospects" }
    end
  end
  
  # Search functionality
  def searchRefinedProspects
    sessUser = session[:user_id]
    if sessUser        
      @wdi_refined_prospects = WdiRefinedProspect.search(params[:srchName], params[:srchEin], params[:srchAddr], 
              params[:srchCity], params[:srchState], params[:srchIncAmnt], params[:srchFirstName], params[:srchLastName],params[:srchEmail],
                  params[:srchTitle], params[:srchHasDonBut], params[:srchWebsite], params[:recLimit])      
      respond_to do |format|
        format.html
        format.json { render json: @wdi_refined_prospects }
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
  
  # Action class to Import records from CSV into wdi_refined_prospects
  def importToRefined
    srcFile = params[:file]
    n=0
    CSV.foreach(srcFile.path, :headers => true) do |row|
      bool = String
      String(row[10]) == "true" ? bool = "1" : bool = "0"
      WdiRefinedProspect.create({
      :e_i_n => row[0],
      :name => row[1],    
      :address => row[2],
      :city => row[3],
      :state => row[4],
      :income_amount => replChar(row[5]),
      :first_name => row[6],
      :last_name => row[7],
      :email => row[8],
      :title => row[9],
      :has_donation_button => bool,
      :website => row[11]
      })
      n=n+1
    end
    respond_to do |format|
      format.html { 
        flash[:notice] = "#{n} Records imported successfully"
        render :file => "wdi_prospects/uploadfile.html.erb" 
      }
    end
    #render :file => 'wdi_prospects/uploadfile.html.erb', :notice => "Records updated"
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
  def delRefinedProspects
#    session[:return_to] = request.fullpath
    params[:delProspectIds].split("$").each do |id|
      @wdi_refined_prospect = WdiRefinedProspect.find(id)
      
      chng = "<b>Deleted Prospect with EIN: "+String(@wdi_refined_prospect.e_i_n)+"</b>"
      @change_history = ChangeHistory.new(username: session[:user_name], email: session[:user_email], change: chng)
      @change_history.save
      
      @wdi_refined_prospect.destroy
    end
    #redirect_to(session[:return_to] || "/search")
#    session[:return_to] = nil
    respond_to do |format|
      format.html { render action: "searchRefinedProspects" }
    end
  rescue => e
    return e.message
  end

end
