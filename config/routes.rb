Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations"
  }

  root "home#index"
  resources :venues

  get "up" => "rails/health#show", as: :rails_health_check

  resources :events do
    resources :queries, only: [ :show, :new, :create, :index ] do
      resources :query_messages, only: [ :create ]
    end
    resources :activities, only: [ :show, :new, :create, :edit, :update, :destroy ] do
    end
    resources :rsvps, only: [ :new, :create, :index ] do
      collection do
        get :special_requests
        get :download_pdf
        get :download_pdf_special_requests
      end
    end
  get :invite_guests
  post :send_invites, on: :member
  end


  get "guest/invites", to: "guests#index", as: :my_invites
  get "guest/events", to: "guests#events", as: :my_events
  get "guest/queries", to: "guests#queries", as: :my_queries
  get "event_manager/:id/queries", to: "event_manager#queries", as: :event_manager_queries



  # Admin dashboard route
  get "admin/dashboard", to: "admin/dashboard#index", as: :admin_dashboard
  get "rsvp/:id/dashboard", to: "rsvps#dashboard", as: :rsvp_dashboard

  get "rsvp/:id/invites", to: "rsvps#invitesSend", as: :rsvp_invites

  namespace :admin do
    resources :employees
  end



  get "admin/show/eventManagers", to: "admin/employees#showEventManagers", as: :show_event_managers
  get "admin/show/activityOwners", to: "admin/employees#showActivityOwners", as: :show_activity_owners

  get "/myevents/:id", to: "event_manager#index", as: :index_event_manager
  get "/myActivities/:id", to: "activity_owner#index", as: :index_activity_manager

  get "/admin/users", to: "admin/dashboard#all_users", as: :admin_all_users

  get "/reports", to: "reports#index", as: :reports
  get "/reports/event_reports", to: "reports#event_reports", as: :event_reports
  get "/reports/rsvp_statistics", to: "reports#rsvp_statistics", as: :rsvp_statistics
  get "/reports/guest_preferences", to: "reports#guest_preferences", as: :guest_preferences
  get "/reports/venue_utilization", to: "reports#venue_utilization", as: :venue_utilization



  post "/events/:id/send_custom_email", to: "events#send_custom_email", as: "send_custom_email"
end
