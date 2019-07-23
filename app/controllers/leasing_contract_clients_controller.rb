class LeasingContractClientsController < ApplicationController
  before_action :set_leasing_contract_client, only: [:show, :edit, :update, :destroy]

  # GET /leasing_contract_clients
  # GET /leasing_contract_clients.json
  def index
    @leasing_contract_clients = LeasingContractClient.all
  end

  # GET /leasing_contract_clients/1
  # GET /leasing_contract_clients/1.json
  def show
  end

  # GET /leasing_contract_clients/new
  def new
    @leasing_contract_client = LeasingContractClient.new
  end

  # GET /leasing_contract_clients/1/edit
  def edit
  end

  # POST /leasing_contract_clients
  # POST /leasing_contract_clients.json
  def create
    @leasing_contract_client = LeasingContractClient.new(leasing_contract_client_params)

    respond_to do |format|
      if @leasing_contract_client.save
        format.html { redirect_to @leasing_contract_client, notice: 'Leasing contract client was successfully created.' }
        format.json { render :show, status: :created, location: @leasing_contract_client }
      else
        format.html { render :new }
        format.json { render json: @leasing_contract_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leasing_contract_clients/1
  # PATCH/PUT /leasing_contract_clients/1.json
  def update
    respond_to do |format|
      if @leasing_contract_client.update(leasing_contract_client_params)
        format.html { redirect_to @leasing_contract_client, notice: 'Leasing contract client was successfully updated.' }
        format.json { render :show, status: :ok, location: @leasing_contract_client }
      else
        format.html { render :edit }
        format.json { render json: @leasing_contract_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leasing_contract_clients/1
  # DELETE /leasing_contract_clients/1.json
  def destroy
    @leasing_contract_client.destroy
    respond_to do |format|
      format.html { redirect_to leasing_contract_clients_url, notice: 'Leasing contract client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leasing_contract_client
      @leasing_contract_client = LeasingContractClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leasing_contract_client_params
      params.require(:leasing_contract_client).permit(:leasing_contract_id, :relationship, :client_id)
    end
end
