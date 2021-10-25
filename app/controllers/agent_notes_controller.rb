class AgentNotesController < ApplicationController
  before_action :set_user
  before_action :set_agent_notes, only: :destroy

  def new
    @agent_note = AgentNote.new(user_id: @user.id)
  end

  def create
    @agent_note = AgentNote.new(agent_note_params)
    @agent_note.creator = current_user
    @agent_note.user_id = @user.id
    respond_to do |format|
          if @agent_note.save
            format.html { redirect_to card_user_path(id: @user.id), notice: 'Accord was successfully created.' }
            format.json { render :show, status: :created, location: @accord }
          else
            format.html { render :new }
            format.json { render json: @agent_note.errors, status: :unprocessable_entity }
          end
        end
  end

  def destroy
    @agent_note.destroy
      respond_to do |format|
          format.html { redirect_to user_user_documents_path(user_id: @user.id), notice: 'Poznámky uspěšně smazány' }
          format.json { head :no_content }
      end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_agent_note
      @user_document = AgentNote.find(params[:id]).decorate
    end

    def agent_note_params
      params.require(:agent_note).permit!
    end
end
