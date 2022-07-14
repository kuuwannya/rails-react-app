class Api::V1::ChatRoomsController < ApplicationController
  def index
    chat_rooms = []

    current_api_v1_user.chat_rooms.order("create_at DESC").each do |chat_room|
      # 部屋の情報（相手のユーザーは誰か、最後に送信されたメッセージはどれか）をJSON形式で作成
      chat_rooms << {
        chat_room: chat_room,
        other_user: chat_room.users.where.not(id: current_api_v1_user.id)[0], #current_user.id以外の人
        last_message: chat_room.message[-1] #[-1]で一番最後の配列を取得

      }
    end

    render json: { status: 200, chat_rooms: chat_rooms }
  end

  def show
    other_user = @chat_room.users.where.not(id: current_api_v1_user.id)[0]
    messages = @chat_room.messages.order("created_at ASC")

    render json: { status: 200, other_user: other_user, message: messages }
  end

  private
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end
end
