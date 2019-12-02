class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.for_user(current_user).decorate
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
    redirect_to @alert.object_find, notice: @alert.to_text
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
  end

  # POST /alerts
  # POST /alerts.json
  def create
    list_of_users = params[:alert][:user_id]
    list_of_users.each do |user|
      unless user.blank?
        @alert = Alert.new(alert_params)
        @alert.user_id = user
        @alert.done = false
        @alert.save
      end
    end
    redirect_to @alert.object_find, notice: 'Hlídač vytvořen'
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    respond_to do |format|
      if @alert.update(alert_params)
        format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @alert }
      else
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to alerts_url, notice: 'Alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(:creator_id, :user_id, :object_id, :object, :text, :alert_type_id, :done, :date_alert)
    end
end
