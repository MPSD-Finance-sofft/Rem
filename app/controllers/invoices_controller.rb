class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = policy_scope(Invoice).order(payout_date: :desc).decorate
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = @invoice.decorate
    respond_to do |format|
      format.pdf { render pdf: "#{@invoice.id}_#{@invoice.agent_user_name}_invoice_#{@invoice.period_year}_#{@invoice.period_month}"}
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.create_invoice(params[:agent_id].to_i)
    respond_to do |format|
        format.html { redirect_to invoices_url, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    authorize @invoice
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoices_url, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:payout_date, :delivery_date, :period_year, :period_month)
    end
end
