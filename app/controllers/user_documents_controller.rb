class UserDocumentsController < ApplicationController
	before_action :set_user
	before_action :set_user_document, only: [:show,:destroy]

	def index
		@user_documents = @user.user_documents.decorate
	end

	def new
		@user_document = UserDocument.new(user_id: @user.id)
	end

	def create
		@user_document = UserDocument.new(user_document_params)
		respond_to do |format|
	      	if @user_document.save
        		format.html { redirect_to user_user_documents_path(user_id: @user.id), notice: 'Accord was successfully created.' }
        		format.json { render :show, status: :created, location: @accord }
      		else
        		format.html { render :new }
        		format.json { render json: @user_document.errors, status: :unprocessable_entity }
      		end
      	end
	end

	def show
	end

	def destroy
		@user_document.destroy
    	respond_to do |format|
      		format.html { redirect_to user_user_documents_path(user_id: @user.id), notice: 'Přílohy uspěšně smazány' }
      		format.json { head :no_content }
    	end
	end

	private
		def set_user
			@user = User.find(params[:user_id])
		end

		def set_user_document
			@user_document = UserDocument.find(params[:id]).decorate
		end

		def user_document_params
			params.require(:user_document).permit!
		end
end