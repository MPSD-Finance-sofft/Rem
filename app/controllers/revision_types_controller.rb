class RevisionTypesController < ApplicationController
  before_action :set_revision_type, only: [:show, :edit, :update, :destroy]

  # GET /revision_types
  # GET /revision_types.json
  def index
    @revision_types = RevisionType.all
  end

  # GET /revision_types/1
  # GET /revision_types/1.json
  def show
  end

  # GET /revision_types/new
  def new
    @revision_type = RevisionType.new
  end

  # GET /revision_types/1/edit
  def edit
  end

  # POST /revision_types
  # POST /revision_types.json
  def create
    @revision_type = RevisionType.new(revision_type_params)

    respond_to do |format|
      if @revision_type.save
        format.html { redirect_to @revision_type, notice: 'Revision type was successfully created.' }
        format.json { render :show, status: :created, location: @revision_type }
      else
        format.html { render :new }
        format.json { render json: @revision_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revision_types/1
  # PATCH/PUT /revision_types/1.json
  def update
    respond_to do |format|
      if @revision_type.update(revision_type_params)
        format.html { redirect_to @revision_type, notice: 'Revision type was successfully updated.' }
        format.json { render :show, status: :ok, location: @revision_type }
      else
        format.html { render :edit }
        format.json { render json: @revision_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revision_types/1
  # DELETE /revision_types/1.json
  def destroy
    @revision_type.destroy
    respond_to do |format|
      format.html { redirect_to revision_types_url, notice: 'Revision type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revision_type
      @revision_type = RevisionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revision_type_params
      params.require(:revision_type).permit(:description)
    end
end
