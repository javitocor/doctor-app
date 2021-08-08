Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :doctors, path: 'doctors', controllers: {
    sessions: 'doctors/sessions',
    registrations: 'doctors/registrations'
  }
  devise_for :patients, path: 'patients', controllers: {
    sessions: 'patients/sessions',
    registrations: 'patients/registrations'
  }
  resources :appointments
  resources :patients
  resources :doctors

  devise_scope :doctor do
    authenticated :doctor do
      namespace :doctors do
        root to: 'appointments#index', as: :authenticated_root
      end
    end
  end

  devise_scope :patient do
    authenticated :patient do
      namespace :patients do
        root to: 'appointments#index', as: :authenticated_root
      end
    end
  end
  
  root to: 'welcome#index'
end
