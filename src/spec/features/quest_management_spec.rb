# frozen_string_literal: true

# spec/features/quest_management_spec.rb

require 'rails_helper'

RSpec.feature 'QuestManagement', type: :feature do
  let(:user) { create(:user) } # 事前にUserのFactoryを作成しておく

  scenario 'ログインして新規クエストを作成する' do
    visit root_path

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    visit quests_path
    click_link 'New Quest'

    fill_in 'Title', with: '新しいクエスト'
    fill_in 'Description', with: 'これはテストです。'
    fill_in 'quest_requester_id', with: 1
    fill_in 'quest_acceptor_id', with: 2
    fill_in 'quest_category', with: 1
    fill_in 'quest_status', with: 1
    fill_in 'quest_difficulty', with: 1
    click_button 'Confirm Quest' # こちらが変更点

    # confirm画面
    # expect(page).to have_content 'Confirm Your Quest'
    click_button 'Create Quest'

    # complete画面
    expect(page).to have_content 'Quest Completed!'
  end

  scenario 'クエストを作成して編集する' do
    quest = create(:quest, requester: user) # 事前にQuestのFactoryを作成しておく

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'

    visit edit_quest_path(quest)
    fill_in 'Title', with: '編集されたクエスト'
    click_button 'Update Quest'

    # expect(page).to have_content 'クエストが更新されました'
  end
end
