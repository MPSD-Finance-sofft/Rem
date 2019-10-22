class ClientEmailsController < ApplicationController
  before_action :set_client_email, only: [:show, :edit, :update, :destroy]

  # GET /client_emails
  # GET /client_emails.json
  def index
    @client_emails = ClientEmail.all
  end

  # GET /client_emails/1
  # GET /client_emails/1.json
  def show
  end

  # GET /client_emails/new
  def new
    @client_email = ClientEmail.new
  end

  # GET /client_emails/1/edit
  def edit
  end

  # POST /client_emails
  # POST /client_emails.json
  def create
    @client_email = ClientEmail.new(client_email_params)

    respond_to do |format|
      if @client_email.save
        format.html { redirect_to @client_email, notice: 'Client email was successfully created.' }
        format.json { render :show, status: :created, location: @client_email }
      else
        format.html { render :new }
        format.json { render json: @client_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_emails/1
  # PATCH/PUT /client_emails/1.json
  def update
    respond_to do |format|
      if @client_email.update(client_email_params)
        format.html { redirect_to @client_email, notice: 'Client email was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_email }
      else
        format.html { render :edit }
        format.json { render json: @client_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_emails/1
  # DELETE /client_emails/1.json
  def destroy
    @client_email.destroy
    respond_to do |format|
      format.html { redirect_to client_emails_url, notice: 'Client email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_email
      @client_email = ClientEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_email_params
      params.require(:client_email).permit(:client_id, :email_id)
    end
end
