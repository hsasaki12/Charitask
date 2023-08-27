# frozen_string_literal: true

# app/controllers/quests_controller.rb

class QuestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @quests = Quest.all
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      # 成功したときの処理
      redirect_to @quest
    else
      # 失敗したときの処理
      render 'new'
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :requester_id, :acceptor_id, :category, :status, :difficulty)
  end
end
