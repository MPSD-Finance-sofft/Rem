class TerrainsController < ApplicationController
  
  
  def create
    @terrain = Terrain.new(terrain_params)
    @terrain.user = current_user

    respond_to do |format|
      if @terrain.save
        format.html { redirect_to @terrain.accord, notice: 'Terrain was successfully created.' }
        format.json { render :show, status: :created, location: @terrain }
      else
        format.html { render :new }
        format.json { render json: @terrain.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @terrain = Terrain.find(params[:id])
    respond_to do |format|
      if @terrain.update(terrain_params)
        format.html { redirect_to @terrain.accord, notice: 'Accord was successfully updated.' }
        format.json { render :show, status: :ok, location: @terrain.accord }
      else
        format.html { render :edit }
        format.json { render json: @terrain.accord.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrain_params
      params.require(:terrain).permit(:accord_id, :user_id, :agent_id, :date_meeting_in_terain, :date_to_terrain, :date_end_terrain)
    end
end
