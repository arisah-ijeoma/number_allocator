Rails.application.routes.draw do
  namespace :api do
    get '/generate_number/(:value)', to: 'phone_numbers#generate_number'
  end
end
