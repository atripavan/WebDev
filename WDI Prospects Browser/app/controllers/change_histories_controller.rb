class ChangeHistoriesController < ApplicationController
  # GET /change_histories
  # GET /change_histories.json
  def index
    sessUser = session[:user_id]
    if sessUser 
      @change_histories = ChangeHistory.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @change_histories }
      end
    else
      redirect_to '/log_in'
    end
  end

  # POST /change_histories
  # POST /change_histories.json
  def create
    @change_history = ChangeHistory.new(params[:change_history])

    respond_to do |format|
      if @change_history.save
        format.html { redirect_to @change_history, notice: 'Change history was successfully created.' }
        format.json { render json: @change_history, status: :created, location: @change_history }
      else
        format.html { render action: "new" }
        format.json { render json: @change_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /change_histories/1
  # DELETE /change_histories/1.json
  def destroy
    @change_history = ChangeHistory.find(params[:id])
    @change_history.destroy

    respond_to do |format|
      format.html { redirect_to change_histories_url }
      format.json { head :no_content }
    end
  end
end
