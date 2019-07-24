class ClientMobilesController < ApplicationController
  before_action :set_client_mobile, only: [:show, :edit, :update, :destroy]

  # GET /client_mobiles
  # GET /client_mobiles.json
  def index
    @client_mobiles = ClientMobile.all
  end

  # GET /client_mobiles/1
  # GET /client_mobiles/1.json
  def show
  end

  # GET /client_mobiles/new
  def new
    @client_mobile = ClientMobile.new
  end

  # GET /client_mobiles/1/edit
  def edit
  end

  # POST /client_mobiles
  # POST /client_mobiles.json
  def create
    @client_mobile = ClientMobile.new(client_mobile_params)

    respond_to do |format|
      if @client_mobile.save
        format.html { redirect_to @client_mobile, notice: 'Client mobile was successfully created.' }
        format.json { render :show, status: :created, location: @client_mobile }
      else
        format.html { render :new }
        format.json { render json: @client_mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_mobiles/1
  # PATCH/PUT /client_mobiles/1.json
  def update
    respond_to do |format|
      if @client_mobile.update(client_mobile_params)
        format.html { redirect_to @client_mobile, notice: 'Client mobile was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_mobile }
      else
        format.html { render :edit }
        format.json { render json: @client_mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_mobiles/1
  # DELETE /client_mobiles/1.json
  def destroy
    @client_mobile.destroy
    respond_to do |format|
      format.html { redirect_to client_mobiles_url, notice: 'Client mobile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_mobile
      @client_mobile = ClientMobile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_mobile_params
      params.require(:client_mobile).permit(:client_id, :mobile_id)
    end
end
