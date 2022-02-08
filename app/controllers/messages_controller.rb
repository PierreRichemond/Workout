class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = current_user.messages.build(messages_params)
    @message.room = current_room
    @message.save
    redirect_to user_exercises_path(current_user)
  end

  private

  def messages_params
    params.require(:message).permit(:body)
  end
end
