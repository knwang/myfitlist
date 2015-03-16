Myfitlist::Application.routes.draw do
  resources :plannings, only: [:show] do
    resources :items, only: [:new, :create, :update, :destroy]
  end
end
