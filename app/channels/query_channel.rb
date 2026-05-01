class QueryChannel < ApplicationCable::Channel
  def subscribed
    @query = Query.find(params[:query_id])
    is_owner   = @query.user_id == current_user.id
    is_manager = @query.event.event_manager_id == current_user.id
    return reject_unauthorized_connection unless is_owner || is_manager || current_user.admin?
    stream_for @query
  end


  def send_message(data)
    message = @query.query_messages.create!(
      message: data['message'],
      sender_type: data['sender_type'],
      user: current_user
    )

    QueryChannel.broadcast_to(@query, {
      message: message.message,
      sender_type: message.sender_type,
      user_name: message.user.name
    })
  end
end
