class SchedulerLogsController < ApplicationController
  before_action :set_scheduler_log, only: [:show, :edit, :update, :destroy]

  # GET /scheduler_logs
  # GET /scheduler_logs.json
  def index
    @scheduler_logs = SchedulerLog.all
  end

  # GET /scheduler_logs/1
  # GET /scheduler_logs/1.json
  def show
  end

  # GET /scheduler_logs/new
  def new
    @scheduler_log = SchedulerLog.new
  end

  # GET /scheduler_logs/1/edit
  def edit
  end

  # POST /scheduler_logs
  # POST /scheduler_logs.json
  def create
    @scheduler_log = SchedulerLog.new(scheduler_log_params)

    respond_to do |format|
      if @scheduler_log.save
        format.html { redirect_to @scheduler_log, notice: 'Scheduler log was successfully created.' }
        format.json { render :show, status: :created, location: @scheduler_log }
      else
        format.html { render :new }
        format.json { render json: @scheduler_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scheduler_logs/1
  # PATCH/PUT /scheduler_logs/1.json
  def update
    respond_to do |format|
      if @scheduler_log.update(scheduler_log_params)
        format.html { redirect_to @scheduler_log, notice: 'Scheduler log was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduler_log }
      else
        format.html { render :edit }
        format.json { render json: @scheduler_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduler_logs/1
  # DELETE /scheduler_logs/1.json
  def destroy
    @scheduler_log.destroy
    respond_to do |format|
      format.html { redirect_to scheduler_logs_url, notice: 'Scheduler log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduler_log
      @scheduler_log = SchedulerLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheduler_log_params
      params.require(:scheduler_log).permit(:kind, :list)
    end
end
