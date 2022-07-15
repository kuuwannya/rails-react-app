class ChatRoomUser < ApplicationRecord
  belongs_to :chat_room
  belongs_to :users
end
