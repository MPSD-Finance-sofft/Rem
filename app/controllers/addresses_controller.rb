class AddressesController < ApplicationController
  before_action :set_add_address, only: [:show, :edit, :update, :destroy]

  # GET /add_addresses
  # GET /add_addresses.json
  def index
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    @addresses = Address.includes(:user_address).includes(:realties).includes(:permanent_address_client).includes(:contact_address_client).order(:district).order(:village)
  end

  # GET /add_addresses/1
  # GET /add_addresses/1.json
  def show
  end

  # GET /add_addresses/new
  def new
    @address = Address.new
  end

  # GET /add_addresses/1/edit
  def edit
  end

  # POST /add_addresses
  # POST /add_addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_addresses/1
  # PATCH/PUT /add_addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_url, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_addresses/1
  # DELETE /add_addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street, :village, :zip, :district, :region, :accord_id, :number)
    end
end
