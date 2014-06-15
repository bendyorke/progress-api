ProgressApi::Application.routes.draw do
  resources :users do; namespace :users do
    resources :workouts,    only: %i[index create update] do
      resources :exercises, only: %i[index create update],
                            controller: 'workouts/exercises'
    end
    resources :exercises,   only: %i[index create update]
    resources :entries,     only: %i[index create]
  end; end

  resources :workouts,      only: %i[index]
  resources :exercises,     only: %i[index]
  resources :registrations, only: %i[create]
  resources :tokens,        only: %i[index]
end
