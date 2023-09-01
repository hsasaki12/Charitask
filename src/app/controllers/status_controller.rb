# frozen_string_literal: true

# app/controllers/status_controller.rb
class StatusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest

  def accept
    if @quest.update(acceptor_id: current_user.id, status: '受注済み')
      # 何らかの成功処理（リダイレクト、通知、etc.）
      redirect_to quest_path(@quest), notice: 'Questを受注しました。'
    else
      # エラーハンドリング
      redirect_to quest_path(@quest), alert: 'Questの受注に失敗しました。'
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end
end
