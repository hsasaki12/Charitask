# app/controllers/messages_controller.rb

class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_quest
  
    def index
    puts params[:id]
      @messages = @quest.messages.order(created_at: :asc)
      @message = Message.new
    end
  
    def create
      @message = @quest.messages.build(message_params)
      @message.sender = current_user
      @message.receiver = @quest.requester_id == current_user.id ? User.find(@quest.acceptor_id) : User.find(@quest.requester_id)
      if @message.save
        redirect_to quest_messages_path(@quest)
      else
        # エラーハンドリング...
      end
    end
  
    private
  
    def set_quest
        @quest = Quest.find(params[:quest_id] || params[:id])
    end
  
    def message_params
      params.require(:message).permit(:content)
    end
  end
  