class FileBoardsController < ApplicationController
  before_action :set_file_board, only: [:show, :edit, :update, :destroy]

  # GET /file_boards
  # GET /file_boards.json
  def index
    @file_boards = FileBoard.all
  end

  # GET /file_boards/1
  # GET /file_boards/1.json
  def show
  end

  # GET /file_boards/new
  def new
    @file_board = FileBoard.new
  end

  # GET /file_boards/1/edit
  def edit
  end

  # POST /file_boards
  # POST /file_boards.json
  def create
    @file_board = FileBoard.new(file_board_params)

    respond_to do |format|
      if @file_board.save
        format.html { redirect_to @file_board, notice: 'File board was successfully created.' }
        format.json { render :show, status: :created, location: @file_board }
      else
        format.html { render :new }
        format.json { render json: @file_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /file_boards/1
  # PATCH/PUT /file_boards/1.json
  def update
    respond_to do |format|
      if @file_board.update(file_board_params)
        format.html { redirect_to @file_board, notice: 'File board was successfully updated.' }
        format.json { render :show, status: :ok, location: @file_board }
      else
        format.html { render :edit }
        format.json { render json: @file_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_boards/1
  # DELETE /file_boards/1.json
  def destroy
    @file_board.destroy
    respond_to do |format|
      format.html { redirect_to file_boards_url, notice: 'File board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_board
      @file_board = FileBoard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_board_params
      params.require(:file_board).permit(:text, :permission, :end, :start, :file)
    end
end
