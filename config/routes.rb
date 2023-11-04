Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  get 'admin', to: 'admin/home#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, except: [:new, :show, :destroy]
    resources :orders, only: [:index, :show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, except: [:show, :edit, :new]
    delete 'destroy_all' => 'cart_items#destroy_all'
    resources :customers, only: [:update]
    get '/customers/withdraw_confirm' => 'customers#withdraw_confirm', as: "withdraw_confirm"
    patch '/customers/withdraw' => 'customers#withdraw', as: "withdraw"
    get '/customers/mypage' => 'customers#show'
    get 'customers/infomation/edit' => 'customers#edit'
    resources :orders, except: [:edit, :update, :destroy]
    get '/orders/thanks' => 'orders#thanks'
    get '/orders/confirm' => 'orders#confirm'
    resources :shipping_addresses, expect: [:show, :new]
  end
end
