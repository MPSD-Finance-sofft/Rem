class UsersController < ApplicationController
	before_action :set_user, only: [:card, :edit, :update, :changes]
	
	def index
    request.format = 'pdf' if params[:commit] == 'PDF'
		@users = policy_scope(User)
		authorize @users
		@filter_users = @users
		@company = @filter_users.map{|a| [a.name_company,a.name_company]}.uniq
		@users =  IndexFilter::IndexServices.new(@users,params).perform.decorate
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render  pdf: "index",:encoding => 'UTF-8', :margin => { :top => 0, :bottom => 0, :left => 0, :right => 0}
      end
    end
	end

	def edit
		authorize @user
		@user = @user.decorate
	end

	def update
		authorize @user
		@user.current_user = current_user
		respond_to do |format|
	      if @user.update(user_params)
	      	Notification.new_notification_for_agents(@user.superior,@user) if @user.superior != current_user
          agent_or_tipster_change_self
	        format.html { redirect_to card_user_path(@user), notice: 'User was successfully updated.' }
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
 		authorize current_user
 	end

 	def card
 		authorize @user
 		@superior = @user.try(:superior).try(:decorate)
 		@user = @user.decorate
 		@ares = @user.ares
    @agentNotes = @user.agent_note.order(asc: :created_at).decorate if current_user.user_or_admin?
 		respond_to do |format|
	        format.html {Activity.create(true_user_id: user_masquerade_owner.try(:id), user_id: current_user.id, what: "Zobrazení uživatele login: #{@user.username}", objet: "User", object_id: @user.id)}
	        format.json {@user}
    	end
 	end

 	def new_user
 		authorize current_user
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

  def change_color
    authorize current_user
    @user = current_user.decorate
  end


 	private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
		params.require(:user).permit!
    end

    def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    		user_params.permit(:username, :email, :password, :password_confirmation)
  		end
	  end

    def agent_or_tipster_change_self
      if current_user.agent? || current_user.tipster?
        Notification::agent_or_tipster_change_self(User.find(18720), current_user)
        Notification::agent_or_tipster_change_self(User.find(31447), current_user)
      end
    end
end
