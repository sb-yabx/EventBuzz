class QueryMessagesController < ApplicationController
  def create
    @query = Query.find(params[:query_id])

    @message = @query.query_messages.create!(
      message: params[:message],
      sender_type: "user",
      user: current_user
    )

    redirect_to event_query_path(@query.event, @query)
  end
end