Rails.application.routes.draw do

   scope module: :ar do
     resources :resources do
       collection do
         get 'generate_resources_and_actions'
       end
     end
   end

end
