# frozen_string_literal: true

class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :title, null: false
      t.text :description
      t.integer :requester_id, null: false, foreign_key: true
      t.integer :acceptor_id, foreign_key: true
      t.integer :category, null: false
      t.integer :status, null: false
      t.integer :difficulty, null: false

      t.timestamps
    end
  end
end
