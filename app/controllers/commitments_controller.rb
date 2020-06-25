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

  def full_index
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" if  !(current_user.admin? || current_user.user?)
    @commitments = Commitment.includes(accord: :address).includes(:commitment_type).order(accord_id: :desc).decorate
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled závazků", objet: "commitments")
  end

  private
    def find_accord
      @accord = Accord.find(params[:accord_id])
    end

end
