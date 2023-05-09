Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'foods#index', as: :authenticated_root

    resources :foods, only: %i[index new create]
    resources :recipes, only: %i[index show new create destroy] do
      member do
        post 'toggle_public'
      end
    end
    resources :inventories, only: %i[index show new create destroy] do
      resources :inventory_foods, only: %i[create update destroy]
    end
    resources :recipe_foods, only: %i[create update destroy]
    resources :public_recipes, only: %i[index show]
    resources :shopping_lists, only: [:index]
  end

  root 'public_recipes#index'
end
