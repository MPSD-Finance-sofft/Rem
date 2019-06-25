class UserMobilesController < ApplicationController
  before_action :set_user_mobile, only: [:show, :edit, :update, :destroy]

  # GET /user_mobiles
  # GET /user_mobiles.json
  def index
    @user_mobiles = UserMobile.all
  end

  # GET /user_mobiles/1
  # GET /user_mobiles/1.json
  def show
  end

  # GET /user_mobiles/new
  def new
    @user_mobile = UserMobile.new
  end

  # GET /user_mobiles/1/edit
  def edit
  end

  # POST /user_mobiles
  # POST /user_mobiles.json
  def create
    @user_mobile = UserMobile.new(user_mobile_params)

    respond_to do |format|
      if @user_mobile.save
        format.html { redirect_to @user_mobile, notice: 'User mobile was successfully created.' }
        format.json { render :show, status: :created, location: @user_mobile }
      else
        format.html { render :new }
        format.json { render json: @user_mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_mobiles/1
  # PATCH/PUT /user_mobiles/1.json
  def update
    respond_to do |format|
      if @user_mobile.update(user_mobile_params)
        format.html { redirect_to @user_mobile, notice: 'User mobile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_mobile }
      else
        format.html { render :edit }
        format.json { render json: @user_mobile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_mobiles/1
  # DELETE /user_mobiles/1.json
  def destroy
    @user_mobile.destroy
    respond_to do |format|
      format.html { redirect_to user_mobiles_url, notice: 'User mobile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_mobile
      @user_mobile = UserMobile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_mobile_params
      params.require(:user_mobile).permit(:user_id, :mobile_id)
    end
end
