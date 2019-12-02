class PlannedPricesController < ApplicationController
  before_action :set_planned_price, only: [:show, :edit, :update, :destroy]

  # GET /planned_prices
  # GET /planned_prices.json
  def index
    @planned_prices = PlannedPrice.all
  end

  # GET /planned_prices/1
  # GET /planned_prices/1.json
  def show
  end

  # GET /planned_prices/new
  def new
    @planned_price = PlannedPrice.new
  end

  # GET /planned_prices/1/edit
  def edit
  end

  # POST /planned_prices
  # POST /planned_prices.json
  def create
    @planned_price = PlannedPrice.new(planned_price_params)

    respond_to do |format|
      if @planned_price.save
        format.html { redirect_to @planned_price.accord, notice: 'Planned price was successfully created.' }
        format.json { render :show, status: :created, location: @planned_price }
      else
        format.html { render :new }
        format.json { render json: @planned_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planned_prices/1
  # PATCH/PUT /planned_prices/1.json
  def update
    respond_to do |format|
      if @planned_price.update(planned_price_params)
        format.html { redirect_to @planned_price, notice: 'Planned price was successfully updated.' }
        format.json { render :show, status: :ok, location: @planned_price }
      else
        format.html { render :edit }
        format.json { render json: @planned_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_prices/1
  # DELETE /planned_prices/1.json
  def destroy
    @planned_price.destroy
    respond_to do |format|
      format.html { redirect_to planned_prices_url, notice: 'Planned price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planned_price
      @planned_price = PlannedPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planned_price_params
      params.require(:planned_price).permit(:accord_id, :user_id, :advertising_price, :market_price, :estimated_selling_price, :real_price)
    end
end
