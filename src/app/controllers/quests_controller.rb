# frozen_string_literal: true

# app/controllers/quests_controller.rb

class QuestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_quest_from_session, only: [:confirm]
  before_action :set_quest, only: %i[edit update show destroy] # この行を変更

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

  def edit
    @quest = Quest.find(params[:id])
  end

  def create
    quest_data = session.delete(:quest_data)

    if quest_data['id']
      # Update existing record
      @quest = Quest.find(quest_data['id'])
      if @quest.update(quest_data)
        redirect_to complete_quests_path
      else
        render :edit
      end
    else
      # Create new record
      @quest = Quest.new(quest_data)
      if @quest.save
        redirect_to complete_quests_path
      else
        render :new
      end
    end
  end

  def update_confirm
    @quest = Quest.find(params[:id])
    @quest.assign_attributes(quest_params) # 更新する属性を割り当てますが、保存はしません。

    if @quest.valid?
      session[:quest_data] = quest_params.to_h.merge(id: @quest.id) # idも含めてセッションに保存
      render :confirm
    else
      redirect_to edit_quest_path(@quest)
    end
  end

  def update
    @quest = Quest.find(params[:id])

    if @quest.update(session.delete(:quest_data))
      redirect_to complete_quests_path
    else
      render :edit
    end
  end

  def complete
    # ここで何か完了後の処理を行う（通常は空でもよい）
  end

  def destroy
    @quest.destroy
    redirect_to quests_path
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
