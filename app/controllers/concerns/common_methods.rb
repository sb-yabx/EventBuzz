module CommonMethods
  extend ActiveSupport::Concern

  def is_admin
    unless current_user&.role == "admin"
      redirect_to root_path, alert: "Acces only to admins"
    end
  end

  def is_event_manager
    unless current_user&.role == "event_manager"
      redirect_to root_path, alert: "Acces only to event managers"
    end
  end

  def is_activity_owner
    unless current_user&.role == "activity_owner"
      redirect_to root_path, alert: "Acces only to activity owner"
    end
  end

  def is_valid_manager
    allowed_roles = ["event_manager", "admin", "activity_owner"]

    unless allowed_roles.include?(current_user&.role)
      flash[:alert] = "Access denied"  
      redirect_to root_path
    end
  end

  def is_guest
    unless current_user&.role == "guest"
      redirect_to root_path, alert: "Access denied"
    end
  end


end
