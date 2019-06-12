class UsersController < ApplicationController
	before_action :set_user, only: [:card, :edit, :update, :changes]
	
	def index
		@users = policy_scope(User)
		authorize @users
	end

	def edit
		authorize @user
	end

	def update
		authorize @user
		respond_to do |format|
	      if @user.update(user_params)
	        format.html { redirect_to card_user_path(@user), notice: 'Accord was successfully updated.' }
	        format.json { render :show, status: :ok, location: @user }
	      else
	        format.html { render :edit }
	        format.json { render json: @accord.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def show
	end

	def destroy
		authorize @users
	end

 	def changes
 	end

 	def card
 	end

 	def new_user
 		@user = User.new
 	end

 	def create_user
 		binding.pry
 		@user = User.new(user_params)
		respond_to do |format|
	      if @user.save
	        format.html { redirect_to card_user_path(@user), notice: 'Uživatel úspěšně založen' }
	        format.json { render :show, status: :ok, location: @user }
	      else
	        format.html { render :new_user }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
    	end
 	end


 	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(User.new.attributes.keys, :avatar ,:password,:email,permission_attributes: [Permission.new.attributes.keys])
    end

    def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    		user_params.permit(:username, :email, :password, :password_confirmation)
  		end
	end

end
