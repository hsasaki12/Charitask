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
end
