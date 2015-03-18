Myfitlist::Application.routes.draw do
  resources :plannings, only: [:new, :create, :show, :update] do
    resources :items, only: [:new, :create, :update, :destroy]
  end
end
