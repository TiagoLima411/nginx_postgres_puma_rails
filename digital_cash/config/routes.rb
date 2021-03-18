Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ExceptionLogger::Engine => "/exception_logger"
  # Devise
  devise_for :users, skip: %i[registrations], controllers: { sessions: 'sessions' }
  devise_scope :user do
    root to: 'dashboard#index'
  end

  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  get 'get_volume_traded_by_month', to: 'dashboard#get_volume_traded_by_month'

  # MEMBERS
  get 'account/edit', to: 'members#edit'
  put 'account/edit_password', to: 'members#edit_password'
  get 'account/register', to: 'members#register'
  get '/convite/:username', to: 'members#register'
  patch 'member_change_password', to: 'members#member_change_password'
  post 'set_payment_password', to: 'members#set_payment_password'
  resources :members, except: [:index]

  # USERS
  resources :users, only: [:index, :show, :edit, :update]

  # Cities
  get 'get_cities', to: 'cities#get_cities_by_state'
  get 'get_cities_by_name', to: 'cities#get_by_name'
  get 'concat_cities', to: 'cities#concat'
  get 'list', to: 'cities#list'

  # Accounts
  resources :accounts
  get 'get_account_from_ajax', to: 'accounts#get_account_from_ajax'
  get '/account/inactive', to: 'accounts#inactive'

  # AccountExtracts
  resources :account_extracts, only: [:index]

  # Incomes
  #resources :incomes, only: [:new, :create]

  # Outgoing
  resources :outgoings, only: [:new, :create] 

  resources :bank_transactions, only: [:new, :create]

  # Recharges
  resources :recharges, only: [:new, :create]
  post '/send_card_transaction', to: 'recharges#send_card_transaction'

  # SessionPayments (Middlewares)
  get '/outgoing_payment_password', to: 'session_payments#middleware_outgoing_payment_password'
  get '/bank_transaction_payment_password', to: 'session_payments#middleware_bank_transaction_payment_password'

  namespace :api, defaults: {format: :json} do
    # CoinGueck paths
    get 'coins/list', to: 'coingecko#index'

    # Utils
    get 'persist_coins_list', to: 'utils#persist_coins_list'
    get 'persist_vs_currency', to: 'utils#persist_vs_currency'
  end

end
