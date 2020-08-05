class RegistersController < ApplicationController
  before_action :set_register, only: [:show, :edit, :update, :destroy]

  # GET /registers
  # GET /registers.json
  def index
    @registers = Register.decorate
  end

  # GET /registers/1
  # GET /registers/1.json
  def show
  end

  # GET /registers/new
  def new
    @register = Register.new
  end

  # GET /registers/1/edit
  def edit
  end

  # POST /registers
  # POST /registers.json
  def create
    save = false
    list_of_clients = params[:register][:client_ids]
    list_of_clients.each do |client|
      next if client.blank?
        @register = Register.new(register_params)
        @register.client_id = client
        @register.user = current_user
        save = @register.save
    end
    respond_to do |format|
      if save
        format.html { redirect_to @register.accord, notice: 'Register was successfully created.' }
        format.json { render :show, status: :created, location: @register }
      else
        format.html { redirect_to @register.accord}
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registers/1
  # PATCH/PUT /registers/1.json
  def update
    set_attributes
    respond_to do |format|
      if @register.update(register_params)
        format.html { redirect_to registers_url, notice: 'Register was successfully updated.' }
        format.json { render :show, status: :ok, location: @register }
      else
        format.html { render :edit }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registers/1
  # DELETE /registers/1.json
  def destroy
    @register.destroy
    respond_to do |format|
      format.html { redirect_to registers_url, notice: 'Register was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_register
      @register = Register.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:register).permit(:accord_id, :client_id, :register_type, :electronic_request, :paper_request, :electronic_extract, :paper_extract, :payout_date, :delivery_date)
    end

    def set_attributes
      return if params[:register][:attributes].blank?
      @register[params[:register][:attributes].keys.first] = params[:register][:attributes].values.first
    end
end
