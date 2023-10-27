Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :audio_files, only: [:show]

  get '/_health' => 'health_check#check'
end
