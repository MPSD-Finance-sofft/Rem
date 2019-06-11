class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :changes]
	def index
		@users = User.all
	end

	def edit

	end
	def update
		respond_to do |format|
	      if @user.update(user_params)
	        format.html { redirect_to root_path, notice: 'Accord was successfully updated.' }
	        format.json { render :show, status: :ok, location: @user }
	      else
	        format.html { render :edit }
	        format.json { render json: @accord.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def destroy
	end

 	def changes
 	end

 	def impersonate
    	user = User.find(params[:id])
    	impersonate_user(user)
    	redirect_to root_path
  	end

  	def stop_impersonating
    	stop_impersonating_user
    	redirect_to root_path
  	end

 	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(User.new.attributes.keys, :avatar ,permission_attributes: [Permission.new.attributes.keys])
    end

end
