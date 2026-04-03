Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
 
  resources :venues

  resources :events do
    resources :activities , only: [:show, :new, :create, :edit, :update, :destroy] do
    end
    resources :rsvps, only: [:new, :create, :index] do
    collection do
      get :special_requests
    end
  end

    get :invite_guests
    post :send_invites, on: :member

  end

  get "guest/invites", to: "guests#index", as: :my_invites
  get "guest/events", to: "guests#events", as: :my_events



  # Admin dashboard route
  get "admin/dashboard", to: "admin/dashboard#index", as: :admin_dashboard
  get "rsvp/:id/dashboard", to: "rsvps#dashboard", as: :rsvp_dashboard

  get "rsvp/:id/invites", to: "rsvps#invitesSend", as: :rsvp_invites

  namespace :admin do
    resources :employees
  end



  get "admin/show/eventManagers" , to: "admin/employees#showEventManagers", as: :show_event_managers
  get "admin/show/activityOwners", to: "admin/employees#showActivityOwners", as: :show_activity_owners

  get "/myevents/:id", to: "event_manager#index", as: :index_event_manager
  get "/myActivities/:id", to: "activity_owner#index", as: :index_activity_manager

  get "/admin/users", to: "admin/dashboard#all_users", as: :admin_all_users

  get "/reports", to: "reports#index", as: :reports
  get "/reports/event_reports", to: "reports#event_reports", as: :event_reports
  get "/reports/rsvp_statistics", to: "reports#rsvp_statistics", as: :rsvp_statistics
  get "/reports/guest_preferences", to: "reports#guest_preferences", as: :guest_preferences
  get "/reports/venue_utilization", to: "reports#venue_utilization", as: :venue_utilization


  post '/events/:id/send_custom_email', to: 'events#send_custom_email', as: 'send_custom_email'


end


