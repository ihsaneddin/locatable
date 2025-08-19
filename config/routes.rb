Locatable::Engine.routes.draw do

  case Locatable.config.enabled_api
  when :grape
    mount Locatable::Grape::Base => '/'
  when :action_controller
    #resources :products, only: [:index]
  end

end
