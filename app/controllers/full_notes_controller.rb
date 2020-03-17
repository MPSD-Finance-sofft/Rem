class FullNotesController < ApplicationController
  def index
    @accord_notes = Note.for_accord(params[:accord_id]).decorate
  end



end