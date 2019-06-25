class UsersController < ApplicationController
	before_action :set_user, only: [:card, :edit, :update, :changes]
	
	def index
		@users = policy_scope(User)
		authorize @users
		@users = UserDecorator.decorate_collection(@users)
	end

	def edit
		authorize @user
	end

	def update
		authorize @user
		@user.current_user = current_user
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
 		@user = @user.decorate
 	end

 	def new_user
 		@user = User.new
 	end

 	def create_user
 		@user = User.new(user_params)
 		@user.current_user = current_user
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
	params.require(:user).permit(User.new.attributes.keys, :avatar ,:password,:email,permission_attributes: [Permission.new.attributes.keys], user_mobile_attributes: [UserMobile.new.attributes.keys, mobile_attributes: [Mobile.new.attributes.keys]], user_address_attributes: [UserAddress.new.attributes.keys, address_attributes: Address.new.attributes.keys])
    end

    def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    		user_params.permit(:username, :email, :password, :password_confirmation)
  		end
	end

end
