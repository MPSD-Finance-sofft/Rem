class CooperationsController < ApplicationController
  before_action :set_cooperation, only: [:show, :edit, :update, :destroy]

  # GET /cooperations
  # GET /cooperations.json
  def index
    authorize Cooperation
    agents_without_cooperation = User.agents.includes(:cooperations).order(:can_sign_in).select{|a| !a.last_date_lost_cooperation}
    @agents = User.agents.includes(:cooperations).select{|a| a.last_date_lost_cooperation}.sort_by(&:last_date_lost_cooperation).reverse + agents_without_cooperation

    @agents_with_cooperation = User.agents.includes(:cooperations).order(date_of_cooperation: :desc).where("date_of_cooperation <= ?", "1.9.2021".to_date).select{|a| a.can_sign_in}
  end

  # GET /cooperations/1
  # GET /cooperations/1.json
  def show
  end

  # GET /cooperations/new
  def new
    @cooperation = Cooperation.new
  end

  # GET /cooperations/1/edit
  def edit
  end

  # POST /cooperations
  # POST /cooperations.json
  def create
    @cooperation = Cooperation.new(cooperation_params)

    respond_to do |format|
      if @cooperation.save
        format.html { redirect_to users_url, notice: 'Cooperation was successfully destroyed.' }
        format.json { redirect_to users_url, notice: 'Cooperation was successfully destroyed.' }
      else
        format.html { render :new }
        format.json { render json: @cooperation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cooperations/1
  # PATCH/PUT /cooperations/1.json
  def update
    respond_to do |format|
      if @cooperation.update(cooperation_params)
        format.html { redirect_to @cooperation, notice: 'Cooperation was successfully updated.' }
        format.json { render :show, status: :ok, location: @cooperation }
      else
        format.html { render :edit }
        format.json { render json: @cooperation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cooperations/1
  # DELETE /cooperations/1.json
  def destroy
    @cooperation.destroy
    respond_to do |format|
      format.html { redirect_to cooperations_url, notice: 'Cooperation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cooperation
      @cooperation = Cooperation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooperation_params
      params.require(:cooperation).permit(:agent_id, :date_of_notice, :day_count, :type_of_notice_id, :user_id, :or_request_id, :notice)
    end
end
