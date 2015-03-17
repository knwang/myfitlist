Myfitlist::Application.routes.draw do
  resources :plannings, only: [:show, :update] do
    resources :items, only: [:new, :create, :update, :destroy]
  end
end
