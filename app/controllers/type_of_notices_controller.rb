class TypeOfNoticesController < ApplicationController
  before_action :set_type_of_notice, only: [:show, :edit, :update, :destroy]

  # GET /type_of_notices
  # GET /type_of_notices.json
  def index
    @type_of_notices = TypeOfNotice.all
  end

  # GET /type_of_notices/1
  # GET /type_of_notices/1.json
  def show
  end

  # GET /type_of_notices/new
  def new
    @type_of_notice = TypeOfNotice.new
  end

  # GET /type_of_notices/1/edit
  def edit
  end

  # POST /type_of_notices
  # POST /type_of_notices.json
  def create
    @type_of_notice = TypeOfNotice.new(type_of_notice_params)

    respond_to do |format|
      if @type_of_notice.save
        format.html { redirect_to @type_of_notice.user_id, notice: 'Type of notice was successfully created.' }
        format.json { render :show, status: :created, location: @type_of_notice.user_id }
      else
        format.html { render :new }
        format.json { render json: @type_of_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_of_notices/1
  # PATCH/PUT /type_of_notices/1.json
  def update
    respond_to do |format|
      if @type_of_notice.update(type_of_notice_params)
        format.html { redirect_to @type_of_notice, notice: 'Type of notice was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_of_notice }
      else
        format.html { render :edit }
        format.json { render json: @type_of_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_of_notices/1
  # DELETE /type_of_notices/1.json
  def destroy
    @type_of_notice.destroy
    respond_to do |format|
      format.html { redirect_to type_of_notices_url, notice: 'Type of notice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_of_notice
      @type_of_notice = TypeOfNotice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_of_notice_params
      params.require(:type_of_notice).permit(:name)
    end
end
