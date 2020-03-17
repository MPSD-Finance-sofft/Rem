class FullNotesController < ApplicationController
  def index
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    @accord_notes = Note.for_accord(params[:accord_id]).decorate
  end
end