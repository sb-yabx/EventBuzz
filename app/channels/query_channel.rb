class QueryChannel < ApplicationCable::Channel
  def subscribed
    @query = Query.find(params[:query_id])
    stream_for @query
  end

  # Explicit method instead of receive
  def send_message(data)
    message = @query.query_messages.create!(
      message: data["message"],
      sender_type: data["sender_type"],
      user: current_user
    )

    QueryChannel.broadcast_to(@query, {
      message: message.message,
      sender_type: message.sender_type,
      user_name: message.user.name
    })
  end
end