# frozen_string_literal: true

# app/controllers/quests_controller.rb

class QuestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_quest_from_session, only: [:confirm]
  before_action :set_quest, only: [:edit, :update, :show] # この行を追加

  def index
    @quests = Quest.all
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def new
    @quest = Quest.new
  end

  def confirm
    @quest = Quest.new(quest_params)
    if @quest.valid?
      session[:quest_data] = quest_params.to_h
      render :confirm
    else
      render :new
    end
  end

  def create
    @quest = Quest.new(session.delete(:quest_data))
    if @quest.save
      redirect_to complete_quests_path
    else
      render :new
    end
  end

  def edit
    # ここに編集前の処理を書く（通常は空でもよい）
  end

  def update
    if @quest.update(quest_params)
      # データが正しく更新された場合
      redirect_to complete_quests_path # このパスは適当です。実際のリダイレクト先に合わせてください。
    else
      # バリデーションに失敗した場合
      render :edit
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :requester_id, :acceptor_id, :category, :status, :difficulty)
  end

  def load_quest_from_session
    @quest = Quest.new(session[:quest_data])
  end

  def set_quest
    @quest = Quest.find(params[:id]) # この行を追加
  end
end
