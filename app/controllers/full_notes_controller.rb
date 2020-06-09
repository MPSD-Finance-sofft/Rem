class FullNotesController < ApplicationController
  def index
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" if  !(current_user.admin? || current_user.user?)
    accord = Accord.find params[:accord_id]
    @accord_notes = Note.for_accord(params[:accord_id]).decorate
    @note_leasing_contract = NoteLeasingContract.for_accord(accord.leasing_contracts.pluck(:id)).decorate
  end
end