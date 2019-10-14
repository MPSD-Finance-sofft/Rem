Rails.application.routes.draw do
  resources :file_boards
  resources :event_types
  resources :contracts, only: :index
  resources :client_mobiles
  resources :dispositions
  resources :leasing_contract_realties
  resources :leasing_contract_clients
  resources :invoices
  resources :boards
  resources :user_addresses
  resources :user_mobiles
  resources :mobiles
  resources :cooperations
  resources :type_of_notices
  resources :rewards
  resources :leasing_contracts do 
    resources :repayments do 
      collection do 
        get :bulk_create
      end
    end
    resources :payments
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
  resources :commitments
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
    end
  end
  resources :accords do
    collection do
      get :changes
    end
    member do
      get :uploads
      patch :create_uploads
      delete :delete_image
    end
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
