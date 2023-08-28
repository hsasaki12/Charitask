# frozen_string_literal: true

# app/controllers/quests_controller.rb

class QuestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_quest_from_session, only: [:confirm]

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

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :requester_id, :acceptor_id, :category, :status, :difficulty)
  end

  def load_quest_from_session
    @quest = Quest.new(session[:quest_data])
  end
end
