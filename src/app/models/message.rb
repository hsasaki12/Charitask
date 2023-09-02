class Message < ApplicationRecord
  belongs_to :quest
  belongs_to :sender
  belongs_to :receiver
end
