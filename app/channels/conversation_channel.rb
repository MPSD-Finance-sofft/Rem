class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find params[:conversation]
    binding.pry
    stream_for conversation
  end
end