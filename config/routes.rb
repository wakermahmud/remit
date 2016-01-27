Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  get "home/index"
  root "home#index"

  resources :studies, only: :show do
    resources :documents, only: :create
    resources :study_notes, only: :create
    # A generic create controller action that allows us to create a
    # publication, dissemination or study_impact
    post "outputs/create"
  end
end
