Rails.application.routes.draw do

  mount HesburghErrors::Engine => "/hesburgh_errors"

  devise_for :users, controllers: { cas_sessions: 'simple_cas' }
end
