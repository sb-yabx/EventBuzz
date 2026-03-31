class ActivityOwnerController < ApplicationController
    before_action :authenticate_user!
    before_action :is_owner

  def index
    @activities = Activity.where(user_id: params[:id])
  end

  private
  def is_owner
    unless current_user&.role == "activity_owner"
    redirect_to root_path, alert: "Only activity owner allowed"
  end
  end

end
