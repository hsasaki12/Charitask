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
        @message = Message.new(message_params)
        @quest = Quest.find(params[:quest_id])  # 既存のQuestを取得
      
        @message.quest_id = @quest.id
      
        # sender_idとreceiver_idを設定。具体的なロジックはアプリケーションに依存。
        if current_user.id == @quest.acceptor_id
          @message.sender_id = @quest.acceptor_id
          @message.receiver_id = @quest.requester_id
        else
          @message.sender_id = @quest.requester_id
          @message.receiver_id = @quest.acceptor_id
        end
      
        if @message.save
          # 成功した処理
          redirect_to quest_messages_path(@quest) 
        else
          # 失敗した処理
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
  