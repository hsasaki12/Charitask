# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'QuestManagement', type: :feature do
  let(:user) { create(:user) }
  let(:login) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  scenario 'ログインして新規クエストを作成する' do
    login
    visit quests_path
    click_link 'New Quest'

    quest_params = {
      Title: '新しいクエスト',
      Description: 'これはテストです。',
      quest_requester_id: 1,
      quest_acceptor_id: 2,
      quest_category: 1,
      quest_status: 1,
      quest_difficulty: 1
    }
    fill_in_form(quest_params)

    click_button 'Confirm Quest'
    click_button 'Create Quest'

    expect(page).to have_content 'Quest Completed!'
  end

  scenario 'クエストを作成して編集する' do
    quest = create(:quest, requester: user)

    login
    visit edit_quest_path(quest)

    fill_in_form(Title: '編集されたクエスト')
    click_button 'Update Quest'

    # expect(page).to have_content 'クエストが更新されました'
  end

  def fill_in_form(fields)
    fields.each do |field, value|
      fill_in field.to_s, with: value
    end
  end
end
