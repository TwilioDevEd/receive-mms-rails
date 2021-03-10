Rails.application.routes.draw do
  resources :mms_resources
  root to: 'mms_resources#index'
end
