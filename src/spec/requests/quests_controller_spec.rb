# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  # 他のアクションに対するテストをここに追加
end
