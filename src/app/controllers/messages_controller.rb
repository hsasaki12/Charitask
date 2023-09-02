# frozen_string_literal: true

# app/controllers/messages_controller.rb

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest

  def index
    Rails.logger.debug params[:id]
    @messages = @quest.messages.order(created_at: :asc)
    @message = Message.new
  end

def create
  @message = Message.new(message_params)
  @quest = Quest.find(params[:quest_id]) # 既存のQuestを取得
  @message.quest_id = @quest.id
  
  # sender_idとreceiver_idを設定。具体的なロジックはアプリケーションに依存。
  if current_user.id == @quest.acceptor_id
    @message.sender_id = @quest.acceptor_id
    @message.receiver_id = @quest.requester_id
  else
    @message.sender_id = @quest.requester_id
    @message.receiver_id = @quest.acceptor_id
  end

  # クエストのステータスとユーザーIDに基づいてメッセージが送信可能かを確認
  can_send_message = (@quest.status == "未着手") || 
                     (current_user.id == @quest.requester_id || current_user.id == @quest.acceptor_id)

  if can_send_message && @message.save
    # 成功した処理
    redirect_to quest_messages_path(@quest)
  else
    # 失敗した処理
    redirect_to quest_messages_path(@quest), alert: 'You cannot send a message in this quest state.'
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
