Rails.application.routes.draw do
  resources :permissions
  resources :addresses
  resources :distributors
  resources :energies
  resources :expert_evidences
  resources :notes
  resources :expense_types
  resources :expenses
  resources :commitment_types
  resources :commitments
  resources :people
  resources :clients
  resources :realties
  resources :realty_types
  resources :users, only: [:index,:edit,:update]  do
    collection do
      get :changes
    end
  end
  resources :accords do
    collection do
      get :changes
    end
  end
  root 'home#index'
  resources :events
  resources :uploads
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
