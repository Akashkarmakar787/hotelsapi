Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

post 'allcomments', to: 'comments#index'
post 'usercomments', to: 'comments#user'
post 'hotelcomments', to: 'comments#hotel'




post 'allhotels', to: 'hotels#index'
post 'hotelsataddress', to: 'hotels#address'
post 'createhotel', to: 'hotels#create'



post 'allusers', to: 'users#index'
end
