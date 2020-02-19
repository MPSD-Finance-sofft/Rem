class ReasonRefusalTypesController < ApplicationController
  before_action :set_reason_refusal_type, only: [:show, :edit, :update, :destroy]

  # GET /reason_refusal_types
  # GET /reason_refusal_types.json
  def index
    @reason_refusal_types = ReasonRefusalType.all
  end

  # GET /reason_refusal_types/1
  # GET /reason_refusal_types/1.json
  def show
  end

  # GET /reason_refusal_types/new
  def new
    @reason_refusal_type = ReasonRefusalType.new
  end

  # GET /reason_refusal_types/1/edit
  def edit
  end

  # POST /reason_refusal_types
  # POST /reason_refusal_types.json
  def create
    @reason_refusal_type = ReasonRefusalType.new(reason_refusal_type_params)

    respond_to do |format|
      if @reason_refusal_type.save
        format.html { redirect_to @reason_refusal_type, notice: 'Reason refusal type was successfully created.' }
        format.json { render :show, status: :created, location: @reason_refusal_type }
      else
        format.html { render :new }
        format.json { render json: @reason_refusal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reason_refusal_types/1
  # PATCH/PUT /reason_refusal_types/1.json
  def update
    respond_to do |format|
      if @reason_refusal_type.update(reason_refusal_type_params)
        format.html { redirect_to @reason_refusal_type, notice: 'Reason refusal type was successfully updated.' }
        format.json { render :show, status: :ok, location: @reason_refusal_type }
      else
        format.html { render :edit }
        format.json { render json: @reason_refusal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reason_refusal_types/1
  # DELETE /reason_refusal_types/1.json
  def destroy
    @reason_refusal_type.destroy
    respond_to do |format|
      format.html { redirect_to reason_refusal_types_url, notice: 'Reason refusal type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reason_refusal_type
      @reason_refusal_type = ReasonRefusalType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reason_refusal_type_params
      params.require(:reason_refusal_type).permit(:description)
    end
end
