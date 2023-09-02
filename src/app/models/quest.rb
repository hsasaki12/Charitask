# frozen_string_literal: true

# app/models/quest.rb

class Quest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :acceptor, class_name: 'User', optional: true
  has_many :messages

  validates :title, presence: true
  validates :category, presence: true
  validates :status, presence: true
  validates :difficulty, presence: true
  
  enum status: { 未着手: 0, 実行前: 1, 処理中: 2, 終了確認: 3, 終了: 4 }
  enum difficulty: { G: 0, F: 1, E: 2, D: 3, C: 4, B: 5, A: 6 }


end
