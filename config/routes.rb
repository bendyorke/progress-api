ProgressApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :workouts,    only: %i[index create update] do
          resources :exercises, only: %i[index create],
                                controller: 'workouts/exercises'
        end
        resources :exercises, only: %i[index create update]
      end

      resources :workouts,  only: %i[index]
      resources :exercises, only: %i[index]
    end
  end
end
