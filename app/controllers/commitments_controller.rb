class CommitmentsController < ApplicationController
  before_action :find_accord, only: [:index]

  # GET /commitments
  # GET /commitments.json
  def index
    @commitments = @accord.commitments
    @commitments_amount_sum =ApplicationDecorator.new(nil).format_number(@commitments.sum(:amount))
    @commitments_real_amount_sum = ApplicationDecorator.new(nil).format_number(@commitments.sum(:real_amount))
    @commitments_amount=  ApplicationDecorator.new(nil).format_number(@commitments.sum(:amount) - @commitments.sum(:real_amount))
    @commitments = @commitments.decorate
    @accord = @accord.decorate
    respond_to do |format|
      format.pdf do
            render  pdf: "zapocet_ke_smlouve_#{@accord.contract_number}"
          end
        end
  end

  private
    def find_accord
      @accord = Accord.find(params[:accord_id])
    end

end
