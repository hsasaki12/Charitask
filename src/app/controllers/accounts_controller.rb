class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @created_quests = Quest.where(requester_id: current_user.id)
    @accepted_quests = Quest.where(acceptor_id: current_user.id)

    # メッセージの送受信が発生しているクエスト
    @messaged_quests = Quest.joins(:messages)
        .where("messages.sender_id = ? OR messages.receiver_id = ?", current_user.id, current_user.id)
        .distinct
  end
end
