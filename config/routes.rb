class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  draw :api
  devise_for :users, controllers: {
     sessions: 'users/sessions',
     registrations: 'users/registrations',
     confirmations: 'users/confirmations'
   }
   root "commodities#index"

  resources :home
  resources :commodities
  resources :users
  resources :orders do
    member do
      get :pay_result
      put :pay
    end
  end
end
