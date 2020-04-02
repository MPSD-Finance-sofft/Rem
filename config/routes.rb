Rails.application.routes.draw do
  resources :full_notes
  resources :sales_contracts
  resources :reason_refusal_types
  resources :document_types
  resources :scheduler_logs
  resources :revisions
  resources :reports do 
    collection do 
      get :agents
      get :users_jobs
    end
  end
  resources :revision_types
  resources :planned_prices, only: [:create]
  resources :alerts
  resources :alert_types
  resources :repaymet_types
  resources :notifications, only: [:index, :show, :deactivate_all] do 
    collection do 
      get :deactivate_all
    end
  end
  resources :room_messages
  resources :rooms
  resources :activities, only: [:index, :search_index] do 
    collection do 
      get :search_index
    end
  end
  resources :user_emails
  resources :note_leasing_contracts
  resources :terrains, only: [:create, :update]
  resources :file_boards
  resources :event_types
  resources :contracts, only: :index
  resources :dispositions
  resources :leasing_contract_realties
  resources :leasing_contract_clients
  resources :invoices
  resources :boards
  resources :user_addresses
  resources :user_mobiles
  resources :cooperations
  resources :type_of_notices
  resources :rewards
  resources :payments
  resources :leasing_contracts do 
    resources :repayments do 
      collection do 
        get :bulk_create
        get :delete_all_repayments
      end
    end
    resources :payments
    member do
      get :uploads
      get :repayments_payments
      patch :create_uploads
      delete :delete_image
      get :reset_rent
    end
  end
  resources :permissions
  resources :addresses
  resources :distributors
  resources :energies
  resources :expert_evidences
  resources :notes, except: [:index]
  resources :expense_types
  resources :expenses
  resources :commitment_types
  resources :clients
  resources :realties
  resources :realty_types
  resources :users, only: [:index,:edit,:update, :card, :new_user, :create_user]  do
    collection do
      get :changes
      get :new_user
      post :create_user
    end
    member do 
      get :card
      get :change_color
    end
    resources :user_documents do
      member do
        patch :uploads
      end
    end
  end
  resources :accords do
    collection do
      get :changes
    end
    member do
      get :uploads
      patch :refusal
      patch :create_uploads
      delete :delete_image
    end
    resources :commitments, only: [:index]
  end
  root 'home#index'
  resources :home do 
    collection do 
      get :balance_price_calculation
    end
  end
  resources :events do 
    collection do 
        post :create_html
        get :index_list
        get :all_list
    end
  end
  resources :conversations, only: [:create,:index] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
   devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
      }
   resources :autocompleter_address do
    collection do
      get :cislo_kat_uzemi_find
      get :cislo_parcely_find
      get :obec_find
      get :ulice_find
      get :cislo_find
      get :validate_adresa
    end
  end
end
