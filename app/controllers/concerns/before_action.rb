module BeforeAction
  extend ActiveSupport::Concern

  [ 'admin', 'event_manager', 'activity_owner', 'guest' ].each do |role|
    define_method("is_#{role}") do
    if current_user&.role != role
      redirect_to root_path, alert: "Access only to #{role.humanize.pluralize}"
      nil
    end
    end
  end

  def is_valid_manager
    allowed_roles = [ 'event_manager', 'admin', 'activity_owner' ]

    if !allowed_roles.include?(current_user&.role)
      flash[:alert] = 'Access denied'
      redirect_to root_path
      nil
    end
  end
end
