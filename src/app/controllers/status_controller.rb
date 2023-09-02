# frozen_string_literal: true

# app/controllers/status_controller.rb
class StatusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest

  def accept
    if @quest.update(acceptor_id: current_user.id, status: '実行前')
      redirect_to "/quests/#{@quest.id}/messages", notice: 'Questを受注しました。'
    else
      # エラーハンドリング...
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end
end
