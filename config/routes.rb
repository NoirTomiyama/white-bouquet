Rails.application.routes.draw do
    root to: 'top#index'
    
    get '/rankings', to: 'top#show'
end
