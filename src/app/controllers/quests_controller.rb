# frozen_string_literal: true

# app/controllers/quests_controller.rb

class QuestsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_quest_from_session, only: [:confirm]
  before_action :set_quest, only: %i[edit update show destroy update_confirm]

  SORT_OPTIONS = {
    'oldest' => { created_at: :asc },
    'title_asc' => { title: :asc },
    'title_desc' => { title: :desc },
    'status_asc' => { status: :asc },
    'status_desc' => { status: :desc },
    'difficulty_asc' => { difficulty: :asc },
    'difficulty_desc' => { difficulty: :desc }
  }.freeze

  def index
    sort_option = SORT_OPTIONS[params[:sort]] || { created_at: :desc }
    @quests = Quest.order(sort_option).page(params[:page]).per(10)
  end

  def show; end

  def new
    session[:is_editing] = false
    @quest = Quest.new
  end

  def confirm
    @quest.assign_attributes(quest_params)
    @quest.requester_id = current_user.id
    if @quest.valid?
      session[:quest_data] = @quest.attributes
      render :confirm
    else
      render :new
    end
  end

  def edit
    session[:is_editing] = true
  end

  def create
    @quest = Quest.new(session.delete(:quest_data)&.symbolize_keys)
    if @quest.save
      redirect_to complete_quests_path
    else
      render :new
    end
  end

  def update_confirm
    @quest.assign_attributes(quest_params)
    @quest.requester_id = current_user.id
    if @quest.valid?
      session[:quest_data] = @quest.attributes
      render :confirm
    else
      render :edit
    end
  end

  def update
    if @quest.update(session.delete(:quest_data)&.symbolize_keys)
      redirect_to complete_quests_path
    else
      render :edit
    end
  end

  def complete
    # Completion logic here if necessary
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
    @quest = Quest.new(session[:quest_data]&.symbolize_keys)
  end

  def set_quest
    @quest = Quest.find(params[:id])
  end
end
