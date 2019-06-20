class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]
  before_action :set_accord, only: [:create]

  # GET /rewards
  # GET /rewards.json
  def index
    @rewards = Reward.all.decorate
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
  end

  # GET /rewards/new
  def new
    @reward = Reward.new
  end

  # GET /rewards/1/edit
  def edit
  end

  # POST /rewards
  # POST /rewards.json
  def create
    @reward = Reward.new
    @reward.create_reward(@accord)

    respond_to do |format|
      if @reward.save
        format.html { redirect_to @accord, notice: 'Reward was successfully created.' }
        format.json { render :show, status: :created, location: @accord }
      else
        format.html { render :new }
        format.json { render json: @accord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rewards/1
  # PATCH/PUT /rewards/1.json
  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards/1
  # DELETE /rewards/1.json
  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to rewards_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @reward = Reward.find(params[:id])
    end

    def set_accord
      @accord = Accord.find(params[:accord_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      #params.require(:reward).permit(:accord_id, :user_id, :agency_commission, :commission_for_the_contract, :invoice_date, :payout_date)
    end
end
